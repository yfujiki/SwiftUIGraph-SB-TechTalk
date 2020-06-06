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
    @State var startPoint: CGPoint?
    @State var endPoint: CGPoint?

    var body: some View {
        ZStack(alignment: .topLeading) {
            MyGraph()
                .stroke(Color.red, lineWidth: 4)
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        if self.startPoint == nil {
                            self.startPoint = value.location
                        } else {
                            self.endPoint = value.location
                        }
                    })
                    .onEnded({ (value) in
                        self.startPoint = nil
                        self.endPoint = nil
                    })
            )
            if startPoint != nil && endPoint != nil {
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2)
                    .offset(x: startPoint!.x, y: startPoint!.y)
                    .frame(width: endPoint!.x - startPoint!.x, height: endPoint!.y - startPoint!.y  )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
