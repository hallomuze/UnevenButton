//
//  un13+1su.swift
//  UnevenButton101
//
//  Created by muzna on 4/25/25.
//
 
import SwiftUI
import UIKit
class un13su: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        // SwiftUI 뷰를 UIHostingController에 임베드합니다.
        let swiftUIController = UIHostingController(rootView: ContentView_13())
        addChild(swiftUIController)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftUIController.view)
        swiftUIController.didMove(toParent: self)

        // Auto Layout을 사용하여 SwiftUI 뷰의 크기와 위치를 설정합니다.
        NSLayoutConstraint.activate([
//            swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            swiftUIController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftUIController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            swiftUIController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

enum SurgingKind: CaseIterable {
    case priceSurge, buysellSurge, volSurge, buyFlow
}

public struct SegmentStatus {
    let defaultName: String
    var name: String {
        !isActive ? defaultName : "🔥\(defaultName)"
    }
    var isActive: Bool
    
    public init(name: String, isActive: Bool) {
        self.defaultName = name
        self.isActive = isActive
    }
}

class vm13: ObservableObject {
    //    @Published var styles: [Style] = []
//    @Published var selectedStyle: Style = .priceSurge
    
    @Published var segmentStatus = [SurgingKind: SegmentStatus]()
    
    private var datasource = [SurgingKind]()
    
    @MainActor
    func fetchStatus() async {
//        try? await Task.sleep(for: .seconds(0.1))
        
        let apiFetched = SurgingKind.allCases
        let count = Int.random(in: 1...4)
        let newDataSource = apiFetched.shuffled().prefix(count)
        
        var newSegmentStatus = getDefaultDataSource()
        
        newDataSource.forEach { surge in
            newSegmentStatus[surge]?.isActive = true
        }
        
        let safeCopied = newSegmentStatus
        await MainActor.run {
            segmentStatus = safeCopied
        }
    }
    
    func getDefaultDataSource() -> SegmentSelection {
        var newSegmentStatus = [SurgingKind: SegmentStatus]()
        newSegmentStatus[.priceSurge] = SegmentStatus(name: "겁나비싸", isActive: false)
        newSegmentStatus[.buysellSurge] = SegmentStatus(name: "사는겁급등", isActive: false)
        newSegmentStatus[.volSurge] = SegmentStatus(name: "거래량폭등", isActive: false)
        newSegmentStatus[.buyFlow] = SegmentStatus(name: "엄청사네", isActive: false)
        return newSegmentStatus
    }
}

typealias SegmentSelection = [SurgingKind: SegmentStatus]
struct ContentView_13: View {
    @StateObject var viewModel = vm13()
    @State private var selectedSegment1 = 0
    @State private var selectedSegment2 = 1
    let segmentTitles1 = ["A", "B", "C", "D"]
    let segmentTitles2 = ["1", "2", "3", "4"]

    var body: some View {
        bodyContent
            .onAppear {
                Task {
                    await viewModel.fetchStatus()
                }
            }
            .onChange(of: selectedSegment1) { newValue in
                print("newValue:\(newValue)")
            }
    }
    var bodyContent: some View {
        VStack {
            Text("Selected Segment 1: \(segmentTitles1[selectedSegment1])")
                .font(.headline)
                .padding()

            GridSegmentControlSwiftUI(selectedIndex: $selectedSegment1, titles: viewModel.segmentStatus)
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .padding()

            Button("call api again", action: {
                Task { await viewModel.fetchStatus() }
            })
//            .buttonStyle(.borderedProminent) //.buttonBorderShape(RoundedRectangle(cornerRadius: 5))
             
            Text("Selected Segment 2: \(segmentTitles2[selectedSegment2])")
                .font(.headline)
                .padding()

            GridSegmentControlSwiftUI(selectedIndex: $selectedSegment2, titles: viewModel.segmentStatus)
                .frame(width: 200, height: 100)
                .padding()

            Spacer()
        }
    }
}

#Preview {
    ContentView_13()
}
