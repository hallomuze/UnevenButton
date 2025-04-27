//
//  UnevenDrawView.swift
//  UnevenButton101
//
//  Created by muzna on 4/26/25.
//

import SwiftUI

struct UnevenDrawView: View {
    var body: some View {
        VStack {
            WindowGridV3(segmentIndex: 0, rows: 2, columns: 2) 
                .frame(width: 200, height: 200) // 크기 지정
            
        }
    }
}

#Preview {
    UnevenDrawView()
}
struct WindowGridV3: View {
    @State var segmentIndex: Int
    let rows: Int
    let columns: Int

    var selectedCorner: UIRectCorner {
        switch segmentIndex {
        case 0: return .topLeft
        case 1: return .topRight
        case 2: return .bottomLeft
        case 3: return .bottomRight
        default: return .topLeft // fallback
        }
    }

    var body: some View {
        ZStack {
            // 전체 격자 기본 선 (회색)
            GridLines(rows: 2, columns: 2, cornerRadius: 10, borderColor: .gray, lineWidth: 1)
                .frame(width: 200, height: 200)

            HighlightedGridLine(
                rows: 2,
                columns: 2,
                corner: selectedCorner // ← 여기를 변경
            )
            .stroke(Color.red, lineWidth: 1)
        }
    }
}
struct GridLines: View {
    var rows: Int
    var columns: Int
    var cornerRadius: CGFloat = 8
    var borderColor: Color = .black
    var lineWidth: CGFloat = 1
    
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
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            }
        }
    }
}
import SwiftUI

struct HighlightedGridLine: Shape {
    var rows: Int
    var columns: Int 
    var corner: UIRectCorner // 하나의 코너만 적용

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)

        let startX: CGFloat
        let startY: CGFloat

        switch corner {
        case .topLeft: // TopLeft
            startX = rect.minX
            startY = rect.minY
        case .topRight: // TopRight
            startX = rect.minX + columnWidth
            startY = rect.minY
        case .bottomLeft: // BottomLeft
            startX = rect.minX
            startY = rect.minY + rowHeight
        case .bottomRight: // BottomRight
            startX = rect.minX + columnWidth
            startY = rect.minY + rowHeight
        default:
            // should not reach to this line
            startX = rect.minX
            startY = rect.minY
        }

        let cellRect = CGRect(x: startX, y: startY, width: columnWidth, height: rowHeight)

        let radius = CGSize(width: 8, height: 8)
        let bezierPath = UIBezierPath(
            roundedRect: cellRect,
            byRoundingCorners: corner,
            cornerRadii: radius
        )

        path.addPath(Path(bezierPath.cgPath))

        return path
    }
}

// 2 x 2
struct HighlightedGridLinexx: Shape {
    var rows: Int
    var columns: Int
    
    var segmentIndex: Int /* topleft, topright, bottomleft, bottomright */
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        // 첫 번째 셀의 좌상단 기준점
        let startX: CGFloat
        let startY: CGFloat
        let endX: CGFloat
        let endY: CGFloat
        
        switch segmentIndex {
        case 0:
            // 첫 번째 셀의 좌상단 기준점
            startX = rect.minX
            startY = rect.minY
            endX = startX + columnWidth
            endY = startY + rowHeight
            
        case 1: // x 의 시작점만 다르다.
            // 첫 번째 셀의 좌상단 기준점
            startX = columnWidth
            startY = rect.minY
            endX = rect.maxX
            endY = startY + rowHeight
            
        case 2: // Bottom Left
            startX = rect.minX
            startY = rect.maxY - rowHeight
            endX = startX + columnWidth
            endY = rect.maxY
            
        case 3: // Bottom Right
            startX = rect.maxX - columnWidth
            startY = rect.maxY - rowHeight
            endX = rect.maxX
            endY = rect.maxY
        default:
            // 첫 번째 셀의 좌상단 기준점
            startX = rect.minX
            startY = rect.minY
            endX = startX + columnWidth
            endY = startY + rowHeight
        }
        
        // top 선
        //        path.move(to: CGPoint(x: startX, y: startY))
        //        path.addLine(to: CGPoint(x: endX, y: startY))
        //
        //        // left 선
        //        path.move(to: CGPoint(x: startX, y: startY))
        //        path.addLine(to: CGPoint(x: startX, y: endY))
        //
        //        // right 선
        //        path.move(to: CGPoint(x: endX, y: startY))
        //        path.addLine(to: CGPoint(x: endX, y: endY))
        //
        //        // bottom 선
        //        path.move(to: CGPoint(x: startX, y: endY))
        //        path.addLine(to: CGPoint(x: endX, y: endY))
        // 선택된 셀의 4면 테두리를 그림
        path.move(to: CGPoint(x: startX, y: startY)) // top-left
        path.addLine(to: CGPoint(x: endX, y: startY)) // top-right
        path.addLine(to: CGPoint(x: endX, y: endY)) // bottom-right
        path.addLine(to: CGPoint(x: startX, y: endY)) // bottom-left
        path.addLine(to: CGPoint(x: startX, y: startY)) // 다시 top-left
        return path
    }
}



struct WindowGridV1: Shape {
    var rows: Int
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        // 가로줄 그리기
        for row in 0...rows {
            let y = CGFloat(row) * rowHeight
            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: y))
        }
        
        // 세로줄 그리기
        for column in 0...columns {
            let x = CGFloat(column) * columnWidth
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        
        return path
    }
}
struct WindowGridV2: Shape {
    var rows: Int
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        // 가로줄 그리기
        for row in 0...rows {
            let y = CGFloat(row) * rowHeight
            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: y))
        }
        
        // 세로줄 그리기
        for column in 0...columns {
            let x = CGFloat(column) * columnWidth
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        
        return path
    }
}
