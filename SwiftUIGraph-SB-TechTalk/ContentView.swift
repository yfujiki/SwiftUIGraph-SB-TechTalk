//
//  ContentView.swift
//  SwiftUIGraph-SB-TechTalk
//
//  Created by Yuichi Fujiki on 6/6/20.
//  Copyright © 2020 yfuiki. All rights reserved.
//

import SwiftUI

struct MyGraph: Shape {
    let originalData: Data = Data(startIndex: 0, endIndex: Data.originalDataCount - 1)

    func path(in rect: CGRect) -> Path {
        let step = rect.width / CGFloat(originalData.endIndex - originalData.startIndex + 1)
        var path = Path()

        for i in originalData.startIndex ... originalData.endIndex {
            let index = i - originalData.startIndex
            let x = CGFloat(index) * step
            let y = originalData[index]
            let point = CGPoint(x: x, y: y)
            if i == originalData.startIndex {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        return path
    }
}

struct ContentView: View {
    var body: some View {
        MyGraph()
            .stroke(Color.red, lineWidth: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
