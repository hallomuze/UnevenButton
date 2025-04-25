//
//  Un11.swift
//  UnevenButton101
//
//  Created by muzna on 4/25/25.
//

import SwiftUI
import UIKit

class un11: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // SwiftUI 뷰를 UIHostingController에 임베드합니다.
        let swiftUIController = UIHostingController(rootView: GridButtonSuV1Wrapper())
        addChild(swiftUIController)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftUIController.view)
        swiftUIController.didMove(toParent: self)

        // Auto Layout을 사용하여 SwiftUI 뷰의 크기와 위치를 설정합니다.
        NSLayoutConstraint.activate([
            swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiftUIController.view.widthAnchor.constraint(equalToConstant: 200),
            swiftUIController.view.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
