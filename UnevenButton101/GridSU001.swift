//
//  GridSU001.swift
//  UnevenButton101
//
//  Created by muzna on 4/24/25.
//

import Foundation
import SwiftUI
import SwiftUI
import SwiftUI




// SwiftUI 뷰를 감싸는 래퍼 뷰 (UIKit에서 상태 관리를 위해)
struct GridButtonSuV1Wrapper: View {
    @State private var selectedSegment = 0
    let segmentTitles = ["A", "B", "C", "D"]

    var body: some View {
        GridButtonSuV1(selectedIndex: $selectedSegment, titles: segmentTitles)
    }
}

// SwiftUI 뷰 (이전 코드와 동일)
struct GridButtonSuV1: View {
    @Binding var selectedIndex: Int
    let titles: [String]
    let columns: [GridItem] = Array(repeating: .init(spacing: 0), count: 2)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<4) { index in
                buttonView(forIndex: index)
            }
        }
        .frame(width: 200, height: 100)
        .border(Color(.systemGray), width: 1)
        .cornerRadius(10)
    }

    @ViewBuilder
    private func buttonView(forIndex index: Int) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            Text(titles[index])
                .font(.headline)
                .foregroundColor(selectedIndex == index ? .black : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .border(Color(.systemGray), width: 1)
                .overlay(selectionOverlay(forIndex: index))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func selectionOverlay(forIndex index: Int) -> some View {
        if selectedIndex == index {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        }
    }
}

// SwiftUI 사용 예시 뷰 (이전 코드와 동일)
struct GridButtonSampleView: View {
    @State private var selectedSegment = 0
    let segmentTitles = ["A", "B", "C", "D"]

    var body: some View {
        VStack {
            Text("Selected Segment: \(segmentTitles[selectedSegment])")
                .font(.headline)
                .padding()

            GridButtonSuV1(selectedIndex: $selectedSegment, titles: segmentTitles)
                .padding()

            Spacer()
        }
    }
}

//@main
//struct GridButtonSampleApp: App {
//    var body: some Scene {
//        WindowGroup {
//            GridButtonSampleView()
//        }
//    }
//}
