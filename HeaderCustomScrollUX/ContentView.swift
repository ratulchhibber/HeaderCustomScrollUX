//
//  ContentView.swift
//  HeaderCustomScrollUX
//
//  Created by Ratul Chhibber on 26/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var subHeaderHeight: CGFloat = 0

    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .top) {
                Color(.systemBackground)
                content()
                subHeader()
                header()
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

//MARK:- Header
extension ContentView {
    
    @ViewBuilder
    private func header() -> some View {
        GeometryReader { proxy in
            VStack {
                Image("elalceweb_Unsplash")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color(.systemBackground))
                    .scaleEffect(scale(for: proxy), anchor: UnitPoint(x: 0.5, y: 0.4))
                    .frame(width: proxy.size.width,
                           height: dynamicHeaderHeight(for: proxy))
                    .clipped()
                    .offset(y: yOffset(for: proxy))
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func scale(for proxy: GeometryProxy) -> CGFloat {
        let scale = HeaderHeight.max / dynamicHeaderHeight(for: proxy)
        return scale > 1 ? scale : 1
    }
}

//MARK:- SubHeader
extension ContentView {
    
    @ViewBuilder
    private func subHeader() -> some View {
        GeometryReader { proxy in
            let isPinned = shouldPinSubHeader(for: proxy)
            subHeaderView()
                .readSize(onChange: { size in
                    subHeaderHeight = size.height
                })
                .background(Color(.systemBackground))
                .padding(.top, isPinned ? HeaderHeight.min : HeaderHeight.max)
                .offset(y: isPinned ? yOffset(for: proxy) : 0)
        }
    }
    
    @ViewBuilder
    private func subHeaderView() -> some View {
        VStack {
            Image("ashleyjurius_Unsplash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 72)
                .clipped()
            
            Text("SubHeader")
        }
        .frame(maxWidth: .infinity)
    }
}

//MARK:- Content
extension ContentView {
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            Group {
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
            }
            Group {
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
                Text("Fruit")
                    .font(.largeTitle)
            }
            
        }
        .background(Color.white)
        .padding(.top, HeaderHeight.max + subHeaderHeight)
    }
}

extension ContentView {
    
    enum HeaderHeight {
        static let max: CGFloat = UIScreen.main.bounds.size.height*0.33
        static let min: CGFloat = 140
    }
    
    private func shouldPinSubHeader(for proxy: GeometryProxy) -> Bool {
        return HeaderHeight.max + yPosition(for: proxy) < HeaderHeight.min
    }
    
    private func dynamicHeaderHeight(for proxy: GeometryProxy) -> CGFloat {
        let yPosition_ = yPosition(for: proxy)
        let currentPosition = HeaderHeight.max + yPosition_
        
        if currentPosition < HeaderHeight.min {
            return HeaderHeight.min
        } else if currentPosition > HeaderHeight.max {
            return HeaderHeight.max + (yPosition_ * 0.5)
        }
        return HeaderHeight.max + yPosition_
    }
    
    private func yPosition(for proxy: GeometryProxy) -> CGFloat {
        return proxy.frame(in: .global).origin.y
    }
    
    private func yOffset(for proxy: GeometryProxy) -> CGFloat {
        let yPosition_ = yPosition(for: proxy)
        return yPosition_ < 0 ? abs(yPosition_) : -yPosition_
    }
}
