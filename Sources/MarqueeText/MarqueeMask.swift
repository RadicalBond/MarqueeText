//
//  MarqueeMask.swift
//  
//
//  Created by Andrew Winn on 4/27/21.
//

import SwiftUI

struct MarqueeMask: ViewModifier {
    var leftFade: CGFloat
    var rightFade: CGFloat

    public func body(content: Content) -> some View {
        content.mask(
            HStack(spacing: 0) {
                Rectangle()
                    .frame(width: 2)
                    .opacity(0)
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: leftFade)
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black]), startPoint: .leading, endPoint: .trailing)
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: rightFade)
                Rectangle()
                    .frame(width: 2)
                    .opacity(0)
            })
    }
}

extension View {
    func marqueeMask(leftFade: CGFloat, rightFade: CGFloat) -> some View {
        self.modifier(MarqueeMask(leftFade: leftFade, rightFade: rightFade))
    }
}

