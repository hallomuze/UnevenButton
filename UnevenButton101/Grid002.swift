//
//  Grid002.swift
//  UnevenButton101
//
//  Created by muzna on 4/24/25.
//

import SwiftUI
import UIKit

import UIKit

//class GridSegmentControl: UIView {
//
//    private let topLeftButton: UIButton
//    private let topRightButton: UIButton
//    private let bottomLeftButton: UIButton
//    private let bottomRightButton: UIButton
//
//    private var actionHandler: ((Int) -> Void)?
//    private var selectedIndex: Int = 0
//    private let separatorColor: UIColor = .lightGray
//    private let separatorLineWidth: CGFloat = 1
//    private var verticalSeparator: CALayer?
//    private var horizontalSeparator: CALayer?
//
//    init() {
//        topLeftButton = UIButton()
//        topRightButton = UIButton()
//        bottomLeftButton = UIButton()
//        bottomRightButton = UIButton()
//
//        super.init(frame: .zero)
//
//        setupButtons()
//        setupLayout()
//        updateSelection(selectedIndex: selectedIndex) // Initial selection 스타일 적용
//        layer.borderColor = UIColor.lightGray.cgColor
//        layer.borderWidth = 1
//        layer.cornerRadius = 10
//        layer.masksToBounds = true
//        addSeparators()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupButtons() {
//        let buttons = [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton]
//        let corners: [CACornerMask] = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//
//        for (index, button) in buttons.enumerated() {
//            button.backgroundColor = .clear
//            button.setTitleColor(.gray, for: .normal)
//            button.titleLabel?.font = UIFont.headline
//            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            button.layer.cornerRadius = 10
//            button.layer.maskedCorners = corners[index]
//            addSubview(button)
//        }
//    }
//
//    private func setupLayout() {
//        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
//        topRightButton.translatesAutoresizingMaskIntoConstraints = false
//        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
//        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            // Top Left Button
//            topLeftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            topLeftButton.topAnchor.constraint(equalTo: topAnchor),
//            topLeftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
//            topLeftButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
//
//            // Top Right Button
//            topRightButton.leadingAnchor.constraint(equalTo: topLeftButton.trailingAnchor),
//            topRightButton.topAnchor.constraint(equalTo: topAnchor),
//            topRightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//            topRightButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
//
//            // Bottom Left Button
//            bottomLeftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            bottomLeftButton.topAnchor.constraint(equalTo: topLeftButton.bottomAnchor),
//            bottomLeftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
//            bottomLeftButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            // Bottom Right Button
//            bottomRightButton.leadingAnchor.constraint(equalTo: bottomLeftButton.trailingAnchor),
//            bottomRightButton.topAnchor.constraint(equalTo: topRightButton.bottomAnchor),
//            bottomRightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//            bottomRightButton.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    private func addSeparators() {
//        // Vertical separator between A/C and B/D
//        let verticalSeparatorLayer = CALayer()
//        verticalSeparatorLayer.backgroundColor = separatorColor.cgColor
//        layer.addSublayer(verticalSeparatorLayer)
//        verticalSeparator = verticalSeparatorLayer
//
//        // Horizontal separator between A/B and C/D
//        let horizontalSeparatorLayer = CALayer()
//        horizontalSeparatorLayer.backgroundColor = separatorColor.cgColor
//        layer.addSublayer(horizontalSeparatorLayer)
//        horizontalSeparator = horizontalSeparatorLayer
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        // Update separator frames on layout
//        verticalSeparator?.frame = CGRect(x: bounds.midX - separatorLineWidth / 2, y: bounds.minY, width: separatorLineWidth, height: bounds.height)
//        horizontalSeparator?.frame = CGRect(x: bounds.minX, y: bounds.midY - separatorLineWidth / 2, width: bounds.width, height: separatorLineWidth)
//    }
//
//    func setTitles(titles: [String]) {
//        guard titles.count == 4 else {
//            print("Error: Titles array must contain exactly 4 strings.")
//            return
//        }
//        topLeftButton.setTitle(titles[0], for: .normal)
//        topRightButton.setTitle(titles[1], for: .normal)
//        bottomLeftButton.setTitle(titles[2], for: .normal)
//        bottomRightButton.setTitle(titles[3], for: .normal)
//    }
//
//    func setActionHandler(handler: @escaping (Int) -> Void) {
//        self.actionHandler = handler
//    }
//
//    @objc private func buttonTapped(_ sender: UIButton) {
//        if sender == topLeftButton {
//            actionHandler?(0)
//            updateSelection(selectedIndex: 0)
//        } else if sender == topRightButton {
//            actionHandler?(1)
//            updateSelection(selectedIndex: 1)
//        } else if sender == bottomLeftButton {
//            actionHandler?(2)
//            updateSelection(selectedIndex: 2)
//        } else if sender == bottomRightButton {
//            actionHandler?(3)
//            updateSelection(selectedIndex: 3)
//        }
//    }
//
//    private func updateSelection(selectedIndex: Int) {
//        self.selectedIndex = selectedIndex
//        let buttons = [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton]
//        for (index, button) in buttons.enumerated() {
//            let isSelected = index == selectedIndex
//            button.setTitleColor(isSelected ? .black : .gray, for: .normal)
//            button.layer.borderWidth = isSelected ? 2 : 0
//            button.layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.clear.cgColor
//        }
//    }
//
//    func setSelectedSegmentIndex(index: Int) {
//        guard (0..<4).contains(index) else { return }
//        updateSelection(selectedIndex: index)
//    }
//}
//
//// MARK: - Helper Extension for UIFont
//extension UIFont {
//    static let headline = UIFont.systemFont(ofSize: 17, weight: .semibold)
//}
// 
//// MARK: - SwiftUI Wrapper (if needed)
//struct GridSegmentControlSwiftUI: UIViewRepresentable {
//    @Binding var selectedIndex: Int
//    var titles: [String]
//
//    func makeUIView(context: Context) -> GridSegmentControl {
//        let control = GridSegmentControl()
//        control.setTitles(titles: titles)
//        control.setActionHandler { index in
//            selectedIndex = index
//        }
//        control.setSelectedSegmentIndex(index: selectedIndex)
//        return control
//    }
//
//    func updateUIView(_ uiView: GridSegmentControl, context: Context) {
//        uiView.setTitles(titles: titles)
//        uiView.setSelectedSegmentIndex(index: selectedIndex)
//    }
//}
//
//struct ContentView: View {
//    @State private var selectedSegment1 = 0
//    @State private var selectedSegment2 = 1
//    let segmentTitles1 = ["A", "B", "C", "D"]
//    let segmentTitles2 = ["1", "2", "3", "4"]
//
//    var body: some View {
//        VStack {
//            Text("Selected Segment 1: \(segmentTitles1[selectedSegment1])")
//                .font(.headline)
//                .padding()
//
//            GridSegmentControlSwiftUI(selectedIndex: $selectedSegment1, titles: segmentTitles1)
//                .frame(width: 200, height: 100)
//                .padding()
//
//            Text("Selected Segment 2: \(segmentTitles2[selectedSegment2])")
//                .font(.headline)
//                .padding()
//
//            GridSegmentControlSwiftUI(selectedIndex: $selectedSegment2, titles: segmentTitles2)
//                .frame(width: 200, height: 100)
//                .padding()
//
//            Spacer()
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
