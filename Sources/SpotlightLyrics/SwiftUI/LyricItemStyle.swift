//
//  LyricItemStyle.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017 Scott Rong. All rights reserved.
//

import SwiftUI

public struct LyricItemStyle {
    public let font: Font
    public let highlightedFont: Font
    public let textColor: Color
    public let highlightedTextColor: Color
    public let lineSpacing: CGFloat

    public init(
        font: Font = .system(size: 16),
        highlightedFont: Font = .system(size: 16),
        textColor: Color = .black,
        highlightedTextColor: Color = .gray,
        lineSpacing: CGFloat = 16
    ) {
        self.font = font
        self.highlightedFont = highlightedFont
        self.textColor = textColor
        self.highlightedTextColor = highlightedTextColor
        self.lineSpacing = lineSpacing
    }
}