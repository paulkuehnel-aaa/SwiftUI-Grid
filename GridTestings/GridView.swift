//
//  GridView.swift
//  GridTestings
//
//  Created by Paul Kühnel on 13.07.22.
//

import SwiftUI

struct GridView: View {
    
    @State var applySize = false
    @State var horizontalShowing = true
    @State var headerShowing = false
    
    var body: some View {
        ZStack {
            if horizontalShowing {
                gridView
            } else {
                verticalGridView
            }
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                MyEqualWidthHStack().callAsFunction({
                    Button {
                        withAnimation {
                            horizontalShowing.toggle()
                        }
                    } label: {
                        Text("Toggle Axis")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    Button {
                        withAnimation {
                            applySize.toggle()
                        }
                    } label: {
                        Text("Apply Size")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                })
                .padding()
                .background(Color(uiColor: .systemGray5))
                .cornerRadius(10)
            }
        }
    }
    
    var gridView: some View {
        ScrollView(.horizontal) {
            Grid {
                GridRow {
                    ForEach(0...32, id: \.self) { value in
                        CardView(viewModel: CardViewModel(color: .randomColor(), title: "Test 1 - \(value)"), hasSize: applySize, height: CGFloat.random(in: 50...240))
                    }
                }
                GridRow {
                    ForEach(0...32, id: \.self) { value in
                        CardView(viewModel: CardViewModel(color: .randomColor(), title: "Test 2 - \(value)"), hasSize: applySize, height: CGFloat.random(in: 50...200))
                    }
                }
                GridRow {
                    ForEach(0...32, id: \.self) { value in
                        CardView(viewModel: CardViewModel(color: .randomColor(), title: "Test 3 - \(value)"), hasSize: applySize, height: CGFloat.random(in: 50...180))
                    }
                }
            }
            .padding()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 84, trailing: 0))
    }
    
    var verticalGridView: some View {
        ScrollView {
            VStack {
                Grid(horizontalSpacing: 12, verticalSpacing: 32) {
                    ForEach(0...32, id: \.self) { row in
                        GridRow {
                            CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: applySize, height: CGFloat.random(in: 50...130))
                            Spacer()
                            CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: applySize, height: CGFloat.random(in: 50...130))
                        }
                        GridRow {
                            CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: applySize, height: CGFloat.random(in: 50...130))
                            CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: applySize, height: CGFloat.random(in: 50...100))
                            CardView(viewModel: CardViewModel(color: .randomColor()), hasSize: applySize, height: CGFloat.random(in: 50...110))
                        }
                    }
                }
                .padding()
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 84)
            }
        }
    }
    
}

struct MyEqualWidthHStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        
        let maxSize = maxSize(subviews: subviews)
        
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        
        return CGSize(
            width: maxSize.width * CGFloat(subviews.count) + totalSpacing,
            height: maxSize.height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        
        let sizeProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        
        var x = bounds.minX + maxSize.width / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY), anchor: .center, proposal: sizeProposal)
            x += maxSize.width + spacing[index]
        }
    }
    
    func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }

        return subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }
    }
    
    func spacing(subviews: Subviews) -> [CGFloat] {
        return subviews.indices.map { index -> CGFloat in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
        }
    }
    
}
