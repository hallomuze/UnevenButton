//
//  un12+su.swift
//  UnevenButton101
//
//  Created by muzna on 4/25/25.
//

/*
import SwiftUI
import UIKit
class un12su: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        // SwiftUI 뷰를 UIHostingController에 임베드합니다.
        let swiftUIController = UIHostingController(rootView: ContentView_v4())
        addChild(swiftUIController)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftUIController.view)
        swiftUIController.didMove(toParent: self)

        // Auto Layout을 사용하여 SwiftUI 뷰의 크기와 위치를 설정합니다.
        NSLayoutConstraint.activate([
            swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            swiftUIController.view.widthAnchor.constraint(equalToConstant: 200),
//            swiftUIController.view.heightAnchor.constraint(equalToConstant: 100) -- 이렇게하면 터치가 안됨.
        ])
    }
}


struct ContentView_v4: View {
    @State private var selectedSegment1 = 0
    @State private var selectedSegment2 = 1
    let segmentTitles1 = ["A", "B", "C", "D"]
    let segmentTitles2 = ["1", "2", "3", "4"]

    var body: some View {
        VStack {
            Text("Selected Segment 1: \(segmentTitles1[selectedSegment1])")
                .font(.headline)
                .padding()

            GridSegmentControlSwiftUI(selectedIndex: $selectedSegment1, titles: segmentTitles1)
                .frame(width: 200, height: 100)
                .padding()

            Text("Selected Segment 2: \(segmentTitles2[selectedSegment2])")
                .font(.headline)
                .padding()

            GridSegmentControlSwiftUI(selectedIndex: $selectedSegment2, titles: segmentTitles2)
                .frame(width: 200, height: 100)
                .padding()

            Spacer()
        }
    }
}

#Preview {
    ContentView_v4()
}
*/
