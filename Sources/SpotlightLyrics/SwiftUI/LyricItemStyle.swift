//
//  LyricItemStyle.swift
//  SpotlightLyrics
//
//  Created by Austin Emmons on 2017/4/2.
//  Copyright © 2017 Austin Emmons. All rights reserved.
//

import SwiftUI

public struct LyricItemStyle {
    public let font: Font
    public let highlightedFont: Font
    public let textColor: Color
    public let highlightedTextColor: Color
    public let lineSpacing: CGFloat
    public let dimmedOpacity: Double
    public let nearbyBlurRadius: CGFloat
    public let farBlurRadius: CGFloat
    public let maxBlurDistance: Int

    public init(
        font: Font = .system(size: 16),
        highlightedFont: Font = .system(size: 16),
        textColor: Color = .black,
        highlightedTextColor: Color = .gray,
        lineSpacing: CGFloat = 16,
        dimmedOpacity: Double = 0.55,
        nearbyBlurRadius: CGFloat = 2,
        farBlurRadius: CGFloat = 4,
        maxBlurDistance: Int = 3
    ) {
        self.font = font
        self.highlightedFont = highlightedFont
        self.textColor = textColor
        self.highlightedTextColor = highlightedTextColor
        self.lineSpacing = lineSpacing
        self.dimmedOpacity = dimmedOpacity
        self.nearbyBlurRadius = nearbyBlurRadius
        self.farBlurRadius = farBlurRadius
        self.maxBlurDistance = maxBlurDistance
    }
}
