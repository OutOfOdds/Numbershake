//
//  Gradient.swift
//  Numbershake
//
//  Created by Mike Mailian on 13.02.2021.
//

import SwiftUI

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing )
    }
}
