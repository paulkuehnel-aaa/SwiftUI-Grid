//
//  CardView.swift
//  GridTestings
//
//  Created by Paul Kühnel on 13.07.22.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardViewModel
    var hasSize: Bool = false
    var height: CGFloat = .zero
    
    var body: some View {
        ZStack {
            if hasSize {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.color)
                    .frame(width: height, height: height)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.color)
                    .aspectRatio(1.0, contentMode: .fit)
            }
            ViewThatFits(in: .horizontal) {
                Text(viewModel.title)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .onTapGesture {
            viewModel.color = .randomColor()
        }
    }
}

extension Color {
    
    static func randomColor() -> Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
    
}
