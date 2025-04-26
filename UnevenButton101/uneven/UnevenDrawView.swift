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
            WindowGridV3(rows: 2, columns: 2)
//                       .stroke(Color.gray, lineWidth: 2) // 선 색과 두께
                       .frame(width: 200, height: 200) // 크기 지정
//                       .padding()
            
            WindowGridV1(rows: 2, columns: 2)
                       .stroke(Color.gray, lineWidth: 2) // 선 색과 두께
                       .frame(width: 200, height: 200) // 크기 지정
                       .padding()
        }
    }
}

#Preview {
    UnevenDrawView()
}
struct WindowGridV3: View {
    var rows: Int
    var columns: Int
    
    var body: some View {
        ZStack {
            // 전체 격자 기본 선 (회색)
            GridLines(rows: rows, columns: columns)
                .stroke(Color.gray.opacity(0.4), lineWidth: 2)
            
            // 강조할 특정 선 (빨간색)
            HighlightedGridLine(rows: rows, columns: columns)
                .stroke(Color.black, lineWidth: 2)
        }
    }
}

struct GridLines: Shape {
    var rows: Int
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        for row in 0...rows {
            let y = CGFloat(row) * rowHeight
            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: y))
        }
        
        for column in 0...columns {
            let x = CGFloat(column) * columnWidth
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        
        return path
    }
}
struct HighlightedGridLine: Shape {
    var rows: Int
    var columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        // 첫 번째 셀의 좌상단 기준점
        let startX = rect.minX
        let startY = rect.minY
        let endX = startX + columnWidth
        let endY = startY + rowHeight
        
        // top 선
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: startY))
        
        // left 선
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX, y: endY))
        
        // right 선
        path.move(to: CGPoint(x: endX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
        // bottom 선
        path.move(to: CGPoint(x: startX, y: endY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
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
