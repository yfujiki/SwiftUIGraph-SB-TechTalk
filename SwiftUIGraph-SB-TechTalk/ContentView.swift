//
//  ContentView.swift
//  SwiftUIGraph-SB-TechTalk
//
//  Created by Yuichi Fujiki on 6/6/20.
//  Copyright © 2020 yfuiki. All rights reserved.
//

import SwiftUI

struct MyGraph: Shape {
    var data: Data

    func path(in rect: CGRect) -> Path {
        let step = rect.width / CGFloat(data.endIndex - data.startIndex + 1)
        var path = Path()

        for i in data.startIndex ... data.endIndex {
            let index = i - data.startIndex
            let x = CGFloat(index) * step
            let y = data[index]
            let point = CGPoint(x: x, y: y)
            if i == data.startIndex {
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

    @State var dataStartIndex: Int = 0
    @State var dataEndIndex: Int = Data.originalDataCount - 1

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .gesture(DragGesture()
                            .onChanged({ (value) in
                                if self.startPoint == nil {
                                    self.startPoint = value.location
                                } else {
                                    self.endPoint = value.location
                                }
                            })
                            .onEnded({ (value) in
                                self.updateDataIndexes(in: geometry)
                                self.startPoint = nil
                                self.endPoint = nil
                            })
                    )
                }
                MyGraph(data: Data(startIndex: dataStartIndex, endIndex: dataEndIndex))
                    .stroke(Color.red, lineWidth: 4)
                if startPoint != nil && endPoint != nil {
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2)
                        .offset(x: startPoint!.x, y: startPoint!.y)
                        .frame(width: endPoint!.x - startPoint!.x, height: endPoint!.y - startPoint!.y  )
                }
            }
            Button("Reset") {
                self.startPoint = nil
                self.endPoint = nil
                self.updateDataIndexes()
            }.padding(.bottom, 40)
        }
    }

    private func updateDataIndexes(in geometry: GeometryProxy? = nil) {
        guard let geometry = geometry,
            let startPoint = startPoint,
            let endPoint = endPoint else {
            dataStartIndex = 0
            dataEndIndex = Data.originalDataCount - 1
            return
        }

        let indexCountInScreen = dataEndIndex - dataStartIndex + 1

        let startX = min(startPoint.x, endPoint.x)
        let endX = max(startPoint.x, endPoint.x)
        dataStartIndex += Int(floor((startX / geometry.size.width) * CGFloat(indexCountInScreen)))
        dataEndIndex -= Int(floor(((geometry.size.width - endX) / geometry.size.width) * CGFloat(indexCountInScreen)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
