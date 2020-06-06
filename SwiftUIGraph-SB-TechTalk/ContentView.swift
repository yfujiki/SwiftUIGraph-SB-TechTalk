//
//  ContentView.swift
//  SwiftUIGraph-SB-TechTalk
//
//  Created by Yuichi Fujiki on 6/6/20.
//  Copyright © 2020 yfuiki. All rights reserved.
//

import SwiftUI

struct MyGraph: Shape {
    let originalData: Data = Data()
    var startIndex: Int = 0
    var endIndex: Int = 399

    func path(in rect: CGRect) -> Path {
        let step = rect.width / CGFloat(endIndex - startIndex + 1)
        var path = Path()

        for i in startIndex ... endIndex {
            let x = CGFloat(i) * step
            let y = originalData.data[i]
            let point = CGPoint(x: x, y: y)
            if i == startIndex {
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
