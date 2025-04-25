//
//  un12+core.swift
//  UnevenButton101
//
//  Created by muzna on 4/25/25.
//
import SwiftUI
import UIKit

// MARK: - SwiftUI Wrapper (if needed)
struct GridSegmentControlSwiftUI: UIViewRepresentable {
    @Binding var selectedIndex: Int
    var titles: [String]

    func makeUIView(context: Context) -> GridSegmentControlV4 {
        let control = GridSegmentControlV4()
        control.setTitles(titles: titles)
        control.setActionHandler { index in
            selectedIndex = index
        }
        control.setSelectedSegmentIndex(index: selectedIndex)
        return control
    }

    func updateUIView(_ uiView: GridSegmentControlV4, context: Context) {
        uiView.setTitles(titles: titles)
        uiView.setSelectedSegmentIndex(index: selectedIndex)
    }
}

