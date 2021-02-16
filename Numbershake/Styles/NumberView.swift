//
//  NumberView.swift
//  Numbershake
//
//  Created by Mike Mailian on 15.02.2021.
//

import SwiftUI

struct NumberView: View {
    var colorMode: Bool
    
    var body: some View {
        if colorMode {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite)
                .frame(minWidth: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask(RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(Color.black
                                                     , Color.clear)))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask(RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(Color.clear, Color.black)))
                )
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.darkStart)
                .frame(minWidth: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.darkEnd, lineWidth: 3)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask(RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(Color.black
                                                     , Color.clear)))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask(RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(Color.clear, Color.black)))
                )
        }
    }
}
