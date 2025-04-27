//
//  GridPopupView.swift
//  UIs
//
//  Created by muzna on 4/27/25.
//

import UIKit
import SwiftUI
 
public final class UseGrid: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
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
            swiftUIController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftUIController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            swiftUIController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
struct ContentView_13: View {
    @StateObject var viewModel = vm14()
    @State private var selectedSegment1 = 0
    let segmentTitles1 = ["A", "B", "C", "D"]
 
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

            WindowGridV3(
                gridIndex: $selectedSegment1,
                titles: $viewModel.segmentStatus,
                rows: 2,
                columns: 2
            )
                .frame(height: 100) // 크기 지정
                .frame(maxWidth: .infinity)
                .padding()

            Button("call api again", action: {
                Task { await viewModel.fetchStatus() }
            })
//            .buttonStyle(.borderedProminent) //.buttonBorderShape(RoundedRectangle(cornerRadius: 5))
              
            Spacer()
        }
    }
}
