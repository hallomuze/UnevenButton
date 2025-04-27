//
//  GridButton.swift
//  UIs
//
//  Created by muzna on 4/27/25.
//

import SwiftUI

//public struct UnevenGridView: View {
//    public init() { }
//    public var body: some View {
//        VStack {
//            Text("innner framework v1")
//            WindowGridV3(segmentIndex: 0, rows: 2, columns: 2)
//                .frame(height: 100) // 크기 지정
//                .frame(maxWidth: .infinity)
//                .padding()
//        }
//    }
//}

//#Preview {
//    UnevenGridView()
//}
public struct WindowGridV3: View {
    @Binding var gridIndex: Int
    @Binding var titles: SegmentSelection
    private let rows: Int
    private let columns: Int
    private let selectColor = Color.black
    private let unselectedColr = Color.gray
    private let boderWidth = CGFloat(1)
    private var selectedCorner: UIRectCorner {
        switch gridIndex {
        case 0: return .topLeft
        case 1: return .topRight
        case 2: return .bottomLeft
        case 3: return .bottomRight
        default: return .topLeft // fallback
        }
    }
    public init(gridIndex: Binding<Int>, titles: Binding<SegmentSelection>, rows: Int, columns: Int) {
        self._gridIndex = gridIndex
        self._titles = titles
        self.rows = rows
        self.columns = columns
    }
    public var body: some View {
        ZStack {
            // 전체 격자 (회색)
            GridLines(rows: 2, columns: 2, cornerRadius: 10, borderColor: unselectedColr, lineWidth: boderWidth)
            
            // 선택영역 격자
            HighlightedGridLine(
                rows: 2,
                columns: 2,
                corner: selectedCorner // ← 여기를 변경
            )
            .strokeBorder(selectColor, lineWidth: boderWidth)
            
            VStack {
                HStack {
                    SementButton(
                        title: titles[.priceSurge]?.name,
                        segmentIndex: 0,
                        isSelected: gridIndex == 0,
                        backgroundColor: .red,
                        hasIcon: titles[.priceSurge]?.isActive,
                        selectedIndex: $gridIndex
                    )
                    SementButton(
                        title: titles[.buysellSurge]?.name,
                        segmentIndex: 1,
                        isSelected: gridIndex == 1,
                        backgroundColor: .orange,
                        hasIcon: titles[.buysellSurge]?.isActive,
                        selectedIndex: $gridIndex
                    )
                }
                HStack {
                    SementButton(
                        title: titles[.volSurge]?.name,
                        segmentIndex: 2,
                        isSelected: gridIndex == 2,
                        backgroundColor: .purple,
                        hasIcon: titles[.volSurge]?.isActive,
                        selectedIndex: $gridIndex
                    )
                    SementButton(
                        title: titles[.buyFlow]?.name,
                        segmentIndex: 3,
                        isSelected: gridIndex == 3,
                        backgroundColor: .blue,
                        hasIcon: titles[.buyFlow]?.isActive,
                        selectedIndex: $gridIndex
                    )
                    
                }
            }
        }
    }
}
struct SementButton: View {
    private let title: String?
    private let segmentIndex: Int
    private let isSelected: Bool
    private let backgroundColor: Color
    private let hasIcon: Bool
    @Binding var selectedIndex: Int // 외부에서 값을 변경할 수 있도록 @Binding 사용
    private var textColor: Color {
        isSelected ? .red : .gray.opacity(0.2)
    }
    private let useBackground = false
    
    public init(title: String?, segmentIndex: Int, isSelected: Bool, backgroundColor: Color, hasIcon: Bool?, selectedIndex: Binding<Int>) {
        self.title = title
        self.segmentIndex = segmentIndex
        self.isSelected = isSelected
        self.backgroundColor = backgroundColor
        self.hasIcon = hasIcon ?? false
        self._selectedIndex = selectedIndex
    }
    var body: some View {
        Button(action: {
            selectedIndex = segmentIndex
        }, label: {
            HStack(spacing: 0) {
                if hasIcon {
                    Image(systemName: "flame")
                        .foregroundColor(textColor)
                }
                Text(title ?? "default title")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(useBackground ? backgroundColor.opacity(0.1) : backgroundColor.opacity(0))
                    .foregroundColor(textColor)
            }
        })
    }
}

struct GridLines: View {
    private let rows: Int
    private let columns: Int
    private var cornerRadius: CGFloat = 8
    private var borderColor: Color = .black
    private var lineWidth: CGFloat = 1
    
    init(rows: Int, columns: Int, cornerRadius: CGFloat, borderColor: Color, lineWidth: CGFloat) {
        self.rows = rows
        self.columns = columns
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.lineWidth = lineWidth
    }
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let columnWidth = width / CGFloat(columns)
            let rowHeight = height / CGFloat(rows)
            
            ZStack {
                // 내부 라인
                Path { path in
                    for row in 1..<rows {
                        let y = CGFloat(row) * rowHeight
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: width, y: y))
                    }
                    
                    for column in 1..<columns {
                        let x = CGFloat(column) * columnWidth
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: height))
                    }
                }
                .stroke(borderColor, lineWidth: lineWidth)
                
                // 외곽 테두리
                //                RoundedRectangle(cornerRadius: cornerRadius)
                //                    .stroke(borderColor, lineWidth: lineWidth)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(borderColor, lineWidth: lineWidth)
                
            }
        }
    }
}

struct HighlightedGridLine: InsettableShape {
    private let rows: Int
    private let columns: Int
    private let corner: UIRectCorner // 하나의 코너만 적용
    private var insetAmount: CGFloat = 0 // InsettableShape 필수
    
    init(rows: Int, columns: Int, corner: UIRectCorner) {
        self.rows = rows
        self.columns = columns
        self.corner = corner
    }
    
    internal func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        let startX: CGFloat
        let startY: CGFloat
        
        // ⭐️ 코너별로 시작점만 inset 적용
        switch corner {
        case .topLeft:
            startX = rect.minX + insetAmount
            startY = rect.minY + insetAmount
        case .topRight:
            startX = rect.minX + columnWidth
            startY = rect.minY + insetAmount
        case .bottomLeft:
            startX = rect.minX + insetAmount
            startY = rect.minY + rowHeight
        case .bottomRight:
            startX = rect.minX + columnWidth
            startY = rect.minY + rowHeight
        default:
            startX = rect.minX
            startY = rect.minY
        }
        
        // ⭐️ width, height는 절대 줄이지 않고 그대로 사용
        let cellRect = CGRect(
            x: startX,
            y: startY,
            width: columnWidth - 1,
            height: rowHeight - 1
        )
        
        let radius = CGSize(width: 8, height: 8)
        let bezierPath = UIBezierPath(
            roundedRect: cellRect,
            byRoundingCorners: corner,
            cornerRadii: radius
        )
        
        path.addPath(Path(bezierPath.cgPath))
        return path
    }
    
    // ⭐️ InsettableShape 필수 메서드
    internal func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
}
