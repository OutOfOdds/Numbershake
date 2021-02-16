//
//  BackgroundColorMode.swift
//  Numbershake
//
//  Created by Mike Mailian on 15.02.2021.
//

import SwiftUI

struct BackgroundColorMode<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    var colorMode: Bool
    
    var body: some View {
        if colorMode {
            if isHighlighted {
                shape
                    .fill(Color.offWhite)
            } else {
                shape
                    .fill (Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        } else {
            if isHighlighted {
                shape
                    .fill(Color.darkStart)
            } else {
                shape
                    .fill(Color.darkStart)
                    .shadow(color: .darkStart, radius: 7, x: -5, y: -5)
                    .shadow(color: .darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}
