//
//  GridPopupViewModel.swift
//  UIs
//
//  Created by muzna on 4/27/25.
//

import Foundation

public enum SurgingKind: CaseIterable {
    case priceSurge, buysellSurge, volSurge, buyFlow
}

public struct SegmentStatus {
    private let defaultName: String
    var name: String {
        // !isActive ? defaultName : "🔥\(defaultName)"
        defaultName
    }
    var isActive: Bool
    
    public init(name: String, isActive: Bool) {
        self.defaultName = name
        self.isActive = isActive
    }
}

public typealias SegmentSelection = [SurgingKind: SegmentStatus]

final class vm14: ObservableObject {
    
    @Published var segmentStatus = SegmentSelection()
    
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
    
    private func getDefaultDataSource() -> SegmentSelection {
        var newSegmentStatus = [SurgingKind: SegmentStatus]()
        newSegmentStatus[.priceSurge] = SegmentStatus(name: "겁나비싸", isActive: false)
        newSegmentStatus[.buysellSurge] = SegmentStatus(name: "사는겁급등", isActive: false)
        newSegmentStatus[.volSurge] = SegmentStatus(name: "거래량폭등", isActive: false)
        newSegmentStatus[.buyFlow] = SegmentStatus(name: "엄청사네", isActive: false)
        return newSegmentStatus
    }
}
