//
//  CardListViewModel.swift
//  GridTestings
//
//  Created by Paul Kühnel on 13.07.22.
//

import Foundation
import SwiftUI

class CardViewModel: ObservableObject {
    
    @Published var color: Color {
        didSet {
            self.title = color.description
        }
    }
    var title: String
    
    init(color: Color, title: String? = nil) {
        self.color = color
        if let title {
            self.title = title
        } else {
            self.title = color.description
        }
    }
    
}
