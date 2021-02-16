//
//  SwiftUIView.swift
//  Numbershake
//
//  Created by Mike Mailian on 15.02.2021.
//

import SwiftUI

// Rectangle button with shadows
struct RectangleButtonStyle: ButtonStyle {
    var colorMode: Bool
    var width: CGFloat
    var height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .font(Font.custom(Baloo.regular, size: 20))
            .background(BackgroundColorMode(isHighlighted: configuration.isPressed, shape: RoundedRectangle(cornerRadius: 10), colorMode: colorMode))
    }
}

// Circle button with shadows
struct CircleButtonStyle: ButtonStyle {
    
    var colorMode: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(BackgroundColorMode(isHighlighted: configuration.isPressed, shape: Circle(), colorMode: colorMode))
    }
}
