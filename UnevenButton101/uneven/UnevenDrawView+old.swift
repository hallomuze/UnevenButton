//
//  UnevenDrawView+old.swift
//  UnevenButton101
//
//  Created by muzna on 4/27/25.
//

import SwiftUI

struct UnevenDrawView_old: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UnevenDrawView_old()
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

