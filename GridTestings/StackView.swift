//
//  StackView.swift
//  GridTestings
//
//  Created by Paul Kühnel on 13.07.22.
//

import SwiftUI

struct StackView: View {
    
    @ObservedObject var topLeft = CardViewModel(color: .red)
    @ObservedObject var topMid = CardViewModel(color: .blue)
    @ObservedObject var topRight = CardViewModel(color: .green)
    @ObservedObject var botLeft = CardViewModel(color: .red)
    @ObservedObject var botMid = CardViewModel(color: .blue)
    @ObservedObject var botRight = CardViewModel(color: .green)
    
    @State var stacksShowing = true
    @State var gridShowing = false
    @State var lazyGridShowing = false
    @State var lazyHGridShowing = false
    @State var showLeaderBoard = false
    @State var leaderBoardSizeFixed = false
    
    @State var gridViewShowing = false
    
    @Namespace var animation
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                if stacksShowing {
                    hstackAndVStack
                } else if gridShowing {
                    combinedStacks
                } else if lazyGridShowing {
                    VStack {
                        HStack {
                            Text("LazyVGrid")
                                .padding()
                                .background(lazyHGridShowing ? Color.white : Color.black)
                                .cornerRadius(10)
                                .foregroundColor(lazyHGridShowing ? Color.black : Color.white)
                                .font(.title3)
                                .matchedGeometryEffect(id: "VStack", in: animation, anchor: .top)
                                .onTapGesture {
                                    withAnimation {
                                        lazyHGridShowing = false
                                    }
                                }
                            Text("or")
                                .matchedGeometryEffect(id: "andor", in: animation)
                            Text("LazyHGrid")
                                .padding()
                                .background(lazyHGridShowing ? Color.black : Color.white)
                                .cornerRadius(10)
                                .foregroundColor(lazyHGridShowing ? Color.white : Color.black)
                                .font(.title3)
                                .matchedGeometryEffect(id: "HStack", in: animation, anchor: .top)
                                .onTapGesture {
                                    withAnimation {
                                        lazyHGridShowing = true
                                    }
                                }
                        }
                        .padding()
                        if lazyHGridShowing {
                            lazyHGrid
                        } else {
                            lazyVGrid
                        }
                    }
                } else if showLeaderBoard {
                    VStack {
                        HStack {
                            Text("Same Height")
                                .padding()
                                .background(!leaderBoardSizeFixed ? Color.black : Color.white)
                                .cornerRadius(10)
                                .foregroundColor(!leaderBoardSizeFixed ? Color.white : Color.black)
                                .font(.title3)
                                .matchedGeometryEffect(id: "VStack", in: animation, anchor: .top)
                                .onTapGesture {
                                    withAnimation {
                                        leaderBoardSizeFixed = false
                                    }
                                }
                            Text("or")
                                .matchedGeometryEffect(id: "andor", in: animation)
                            Text("Diff. Height")
                                .padding()
                                .background(leaderBoardSizeFixed ? Color.black : Color.white)
                                .cornerRadius(10)
                                .foregroundColor(leaderBoardSizeFixed ? Color.white : Color.black)
                                .font(.title3)
                                .matchedGeometryEffect(id: "HStack", in: animation, anchor: .top)
                                .onTapGesture {
                                    withAnimation {
                                        leaderBoardSizeFixed = true
                                    }
                                }
                        }
                        .padding()
                        leaderBoard
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                gridShowing = false
                                stacksShowing = true
                                lazyGridShowing = false
                                showLeaderBoard = false
                            }
                        } label: {
                            Text("1")
                                .padding()
                                .foregroundColor(.white)
                                .background(Circle().fill(stacksShowing ? .blue : .gray))
                        }
                        Button {
                            withAnimation {
                                gridShowing = true
                                stacksShowing = false
                                lazyGridShowing = false
                                showLeaderBoard = false
                            }
                        } label: {
                            Text("2")
                                .padding()
                                .foregroundColor(.white)
                                .background(Circle().fill(gridShowing ? .blue : .gray))
                        }
                        Button {
                            withAnimation {
                                gridShowing = false
                                stacksShowing = false
                                lazyGridShowing = true
                                showLeaderBoard = false
                            }
                        } label: {
                            Text("3")
                                .padding()
                                .foregroundColor(.white)
                                .background(Circle().fill(lazyGridShowing ? .blue : .gray))
                        }
                        Button {
                            withAnimation {
                                gridShowing = false
                                stacksShowing = false
                                lazyGridShowing = false
                                showLeaderBoard = true
                            }
                        } label: {
                            Text("L")
                                .padding()
                                .foregroundColor(.white)
                                .background(Circle().fill(showLeaderBoard ? .blue : .gray))
                        }
                        NavigationLink(destination: GridView()) {
                            Text("Grid")
                                .padding()
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(uiColor: .systemGreen)))
                        }
                    }
                    .padding(8)
                    .background(Color(uiColor: .systemGray5))
                    .cornerRadius(10)
                }
            }
        }
    }
    
    var hstackAndVStack: some View {
        VStack {
            VStack {
                Text("HStack:")
                    .font(.title3)
                    .foregroundColor(.green)
                    .matchedGeometryEffect(id: "HStack", in: animation)
                HStack {
                    CardView(viewModel: topLeft)
                        .matchedGeometryEffect(id: "red top", in: animation)
                    CardView(viewModel: topMid)
                        .matchedGeometryEffect(id: "green top", in: animation)
                    CardView(viewModel: topRight)
                        .matchedGeometryEffect(id: "blue top", in: animation)
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(20)
            }
            Spacer()
            VStack {
                Text("VStack:")
                    .font(.title3)
                    .foregroundColor(.red)
                    .matchedGeometryEffect(id: "VStack", in: animation)
                VStack {
                    CardView(viewModel: botLeft)
                        .matchedGeometryEffect(id: "red bot", in: animation)
                    CardView(viewModel: botMid)
                        .matchedGeometryEffect(id: "green bot", in: animation)
                    CardView(viewModel: botRight)
                        .matchedGeometryEffect(id: "blue bot", in: animation)
                }
                .padding()
                .background(Color.red.opacity(0.2))
                .cornerRadius(20)
            }
        }
        .padding()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 58, trailing: 0))
    }
    
    var combinedStacks: some View {
        VStack {
            HStack {
                Text("VStack")
                    .foregroundColor(.red)
                    .font(.title3)
                    .matchedGeometryEffect(id: "VStack", in: animation)
                Text("and")
                    .matchedGeometryEffect(id: "andor", in: animation)
                Text("HStack:")
                    .foregroundColor(.green)
                    .font(.title3)
                    .matchedGeometryEffect(id: "HStack", in: animation)
            }
            VStack {
                HStack {
                    CardView(viewModel: topLeft)
                        .matchedGeometryEffect(id: "red top", in: animation)
                    CardView(viewModel: topMid)
                        .matchedGeometryEffect(id: "green top", in: animation)
                    CardView(viewModel: topRight)
                        .matchedGeometryEffect(id: "blue top", in: animation)
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(20)
                HStack {
                    CardView(viewModel: botLeft)
                        .matchedGeometryEffect(id: "red bot", in: animation)
                    CardView(viewModel: botMid)
                        .matchedGeometryEffect(id: "green bot", in: animation)
                    CardView(viewModel: botRight)
                        .matchedGeometryEffect(id: "blue bot", in: animation)
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(20)
            }
            .padding()
            .background(Color.red.opacity(0.2))
            .cornerRadius(20)
        }
        .padding()
    }
    
    var lazyVGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                CardView(viewModel: topLeft)
                    .matchedGeometryEffect(id: "red top", in: animation)
                CardView(viewModel: topMid)
                    .matchedGeometryEffect(id: "green top", in: animation)
                CardView(viewModel: topRight)
                    .matchedGeometryEffect(id: "blue top", in: animation)
                CardView(viewModel: botLeft)
                    .matchedGeometryEffect(id: "red bot", in: animation)
                CardView(viewModel: botMid)
                    .matchedGeometryEffect(id: "green bot", in: animation)
                CardView(viewModel: botRight)
                    .matchedGeometryEffect(id: "blue bot", in: animation)
                ForEach(0...6, id: \.self) { _ in
                    CardView(viewModel: CardViewModel(color: .red))
                    CardView(viewModel: CardViewModel(color: .blue))
                    CardView(viewModel: CardViewModel(color: .green))
                }
            }
            .padding()
        }
    }
    
    var lazyHGrid: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                CardView(viewModel: topLeft)
                    .matchedGeometryEffect(id: "red top", in: animation)
                CardView(viewModel: topMid)
                    .matchedGeometryEffect(id: "green top", in: animation)
                CardView(viewModel: topRight)
                    .matchedGeometryEffect(id: "blue top", in: animation)
                CardView(viewModel: botLeft)
                    .matchedGeometryEffect(id: "red bot", in: animation)
                CardView(viewModel: botMid)
                    .matchedGeometryEffect(id: "green bot", in: animation)
                CardView(viewModel: botRight)
                    .matchedGeometryEffect(id: "blue bot", in: animation)
                ForEach(0...6, id: \.self) { _ in
                    CardView(viewModel: CardViewModel(color: .red))
                    CardView(viewModel: CardViewModel(color: .blue))
                    CardView(viewModel: CardViewModel(color: .green))
                }
            }
            .padding()
        }
    }
    
    var leaderBoard: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                CardView(viewModel: topLeft)
                    .matchedGeometryEffect(id: "red top", in: animation)
                CardView(viewModel: topMid)
                    .matchedGeometryEffect(id: "green top", in: animation)
                CardView(viewModel: topRight)
                    .matchedGeometryEffect(id: "blue top", in: animation)
                CardView(viewModel: botLeft)
                    .matchedGeometryEffect(id: "red bot", in: animation)
                CardView(viewModel: botMid)
                    .matchedGeometryEffect(id: "green bot", in: animation)
                CardView(viewModel: botRight)
                    .matchedGeometryEffect(id: "blue bot", in: animation)
                ForEach(0...16, id: \.self) { value in
                    CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: leaderBoardSizeFixed, height: CGFloat.random(in: 50...150))
                    CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: leaderBoardSizeFixed, height: CGFloat.random(in: 50...150))
                    CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: leaderBoardSizeFixed, height: CGFloat.random(in: 50...150))
                }
            }
        }
        .padding()
    }
    
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        StackView()
    }
}
