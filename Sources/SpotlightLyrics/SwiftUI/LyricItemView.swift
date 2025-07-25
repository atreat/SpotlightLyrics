//
//  LyricItemView.swift
//  SpotlightLyrics
//
//  Created by Austin Emmons on 2017/7/28.
//  Copyright © 2017 Austin Emmons. All rights reserved.
//

import SwiftUI

struct LyricItemView: View {
    let item: LyricsItem
    let highlighted: Bool
    let font: Font
    let highlightedFont: Font
    let textColor: Color
    let highlightedTextColor: Color

    var body: some View {
        Text(item.text)
            .font(highlighted ? highlightedFont : font)
            .foregroundColor(highlighted ? highlightedTextColor : textColor)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack(spacing: 20) {
        LyricItemView(
            item: LyricsItem(time: 0, text: "Normal Lyric Line"),
            highlighted: false,
            font: .system(size: 16),
            highlightedFont: .system(size: 16, weight: .bold),
            textColor: .primary,
            highlightedTextColor: .blue
        )
        LyricItemView(
            item: LyricsItem(time: 0, text: "Highlighted Lyric Line"),
            highlighted: true,
            font: .system(size: 16),
            highlightedFont: .system(size: 16, weight: .bold),
            textColor: .primary,
            highlightedTextColor: .blue
        )
    }
    .padding()
}
