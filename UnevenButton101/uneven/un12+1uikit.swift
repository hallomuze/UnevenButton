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

