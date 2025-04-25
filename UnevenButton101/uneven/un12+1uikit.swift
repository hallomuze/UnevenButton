//
//  un12.swift
//  UnevenButton101
//
//  Created by muzna on 4/25/25.
//
import SwiftUI
import UIKit

// MARK: - Example ViewController (for UIKit)
class un12: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let gridSegmentControl1 = GridSegmentControlV4()
      //  gridSegmentControl1.setTitles(titles: ["A", "B", "C", "D"])
        gridSegmentControl1.setActionHandler { index in
            print("Segment 1 tapped: \(index)")
        }
        gridSegmentControl1.setSelectedSegmentIndex(index: 0)

        let gridSegmentControl2 = GridSegmentControlV4()
      //  gridSegmentControl2.setTitles(titles: ["1", "2", "3", "4"])
        gridSegmentControl2.setActionHandler { index in
            print("Segment 2 tapped: \(index)")
        }
        gridSegmentControl2.setSelectedSegmentIndex(index: 1)

        let stackView = UIStackView(arrangedSubviews: [gridSegmentControl1, gridSegmentControl2])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        stackView.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            gridSegmentControl1.heightAnchor.constraint(equalToConstant: 100),
            gridSegmentControl2.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

class GridSegmentControlV4: UIView {

    private let topLeftButton: UIButton
    private let topRightButton: UIButton
    private let bottomLeftButton: UIButton
    private let bottomRightButton: UIButton

    private var actionHandler: ((Int) -> Void)? // 버튼 탭 시 호출될 핸들러
    private var selectedIndex: Int = 0 // 현재 선택된 버튼의 인덱스 (0: 좌상, 1: 우상, 2: 좌하, 3: 우하)
    private let separatorColor: UIColor = .lightGray // 구분선 색상
    private let separatorLineWidth: CGFloat = 1 // 구분선 두께
    private var verticalSeparator: CALayer? // 수직 구분선 레이어
    private var horizontalSeparator: CALayer? // 수평 구분선 레이어

    init() {
        topLeftButton = UIButton()
        topRightButton = UIButton()
        bottomLeftButton = UIButton()
        bottomRightButton = UIButton()

        super.init(frame: .zero)

        setupButtons() // 버튼 기본 설정
        setupLayout() // 버튼 레이아웃 설정
        updateSelection(selectedIndex: selectedIndex) // 초기 선택 상태 스타일 적용
        layer.borderColor = UIColor.lightGray.cgColor // 뷰 외곽 테두리 색상
        layer.borderWidth = 1 // 뷰 외곽 테두리 두께
        layer.cornerRadius = 10 // 뷰 외곽 코너 둥글기
        layer.masksToBounds = true // 경계 내 콘텐츠만 보이도록 설정
        addSeparators() // 내부 구분선 추가
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtons() {
        let buttons = [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton]
        let corners: [CACornerMask] = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner] // 각 버튼의 둥근 모서리 설정

        for (index, button) in buttons.enumerated() {
            button.backgroundColor = .clear // 버튼 배경색 투명
            button.setTitleColor(.gray, for: .normal) // 기본 텍스트 색상 회색
            button.titleLabel?.font = UIFont.headline // 텍스트 폰트 설정
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside) // 버튼 탭 액션 연결
            button.layer.cornerRadius = 10 // 버튼 코너 둥글기 (뷰의 둥글기와 동일하게 설정)
            button.layer.maskedCorners = corners[index] // 특정 코너만 둥글게 마스크 처리
            addSubview(button) // 뷰에 버튼 추가
        }
    }

    private func setupLayout() {
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Top Left Button (좌상단 버튼)
            topLeftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLeftButton.topAnchor.constraint(equalTo: topAnchor),
            topLeftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            topLeftButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            // Top Right Button (우상단 버튼)
            topRightButton.leadingAnchor.constraint(equalTo: topLeftButton.trailingAnchor),
            topRightButton.topAnchor.constraint(equalTo: topAnchor),
            topRightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            topRightButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            // Bottom Left Button (좌하단 버튼)
            bottomLeftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLeftButton.topAnchor.constraint(equalTo: topLeftButton.bottomAnchor),
            bottomLeftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            bottomLeftButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Bottom Right Button (우하단 버튼)
            bottomRightButton.leadingAnchor.constraint(equalTo: bottomLeftButton.trailingAnchor),
            bottomRightButton.topAnchor.constraint(equalTo: topRightButton.bottomAnchor),
            bottomRightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomRightButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addSeparators() {
        // Vertical separator between A/C and B/D (좌/하 그룹과 우/하 그룹 사이 수직 구분선)
        let verticalSeparatorLayer = CALayer()
        verticalSeparatorLayer.backgroundColor = separatorColor.cgColor
        layer.addSublayer(verticalSeparatorLayer)
        verticalSeparator = verticalSeparatorLayer

        // Horizontal separator between A/B and C/D (상단 그룹과 하단 그룹 사이 수평 구분선)
        let horizontalSeparatorLayer = CALayer()
        horizontalSeparatorLayer.backgroundColor = separatorColor.cgColor
        layer.addSublayer(horizontalSeparatorLayer)
        horizontalSeparator = horizontalSeparatorLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update separator frames on layout (레이아웃 변경 시 구분선 프레임 업데이트)
        verticalSeparator?.frame = CGRect(x: bounds.midX - separatorLineWidth / 2, y: bounds.minY, width: separatorLineWidth, height: bounds.height)
        horizontalSeparator?.frame = CGRect(x: bounds.minX, y: bounds.midY - separatorLineWidth / 2, width: bounds.width, height: separatorLineWidth)
    }

    func setTitles(titles: SegmentSelection) {
        guard titles.count == 4 else {
            print("Error: Titles array must contain exactly 4 strings.")
            return
        }
        topLeftButton.setTitle(titles[.priceSurge]?.name, for: .normal)
        topRightButton.setTitle(titles[.buysellSurge]?.name, for: .normal)
        bottomLeftButton.setTitle(titles[.volSurge]?.name, for: .normal)
        bottomRightButton.setTitle(titles[.buyFlow]?.name, for: .normal)
        
//        topRightButton.setTitle(titles[1], for: .normal)
//        bottomLeftButton.setTitle(titles[2], for: .normal)
//        bottomRightButton.setTitle(titles[3], for: .normal)
    }

    func setActionHandler(handler: @escaping (Int) -> Void) {
        self.actionHandler = handler
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == topLeftButton {
            actionHandler?(0)
            updateSelection(selectedIndex: 0)
        } else if sender == topRightButton {
            actionHandler?(1)
            updateSelection(selectedIndex: 1)
        } else if sender == bottomLeftButton {
            actionHandler?(2)
            updateSelection(selectedIndex: 2)
        } else if sender == bottomRightButton {
            actionHandler?(3)
            updateSelection(selectedIndex: 3)
        }
    }

    private func updateSelection(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        let buttons = [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton]
        for (index, button) in buttons.enumerated() {
            let isSelected = index == selectedIndex
            button.setTitleColor(isSelected ? .black : .gray, for: .normal) // 선택된 버튼 텍스트 색상 검정, 아니면 회색
            button.layer.borderWidth = isSelected ? 2 : 0 // 선택된 버튼 테두리 두께 2, 아니면 0 (테두리 숨김)
            button.layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.clear.cgColor // 선택된 버튼 테두리 색상 검정, 아니면 투명
        }
    }

    func setSelectedSegmentIndex(index: Int) {
        guard (0..<4).contains(index) else { return }
        updateSelection(selectedIndex: index)
    }
}

// MARK: - Helper Extension for UIFont
extension UIFont {
    static let headline = UIFont.systemFont(ofSize: 17, weight: .semibold)
}
