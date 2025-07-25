//
//  KaraokeView.swift
//  SpotlightLyrics
//
//  Created by Austin Emmons on 2017/4/2.
//  Copyright © 2017 Austin Emmons. All rights reserved.
//

import SwiftUI
import UIKit

public struct KaraokeView: View {

    // MARK: - Properties

    @State private var lyricsItems: [LyricsItem] = []
    @State private var focusedLyricIdx: Int? = nil
    @Binding private var currentTime: TimeInterval
    @Binding private var isPlaying: Bool

    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let style: LyricItemStyle
    private let parser: LyricsParser

    // MARK: - Public properties

    public var currentLyric: String? {
        guard let lastIndex = focusedLyricIdx else {
            return nil
        }
        guard lastIndex < lyricsItems.count else {
            return nil
        }

        return lyricsItems[lastIndex].text
    }

    // MARK: - Initialization

    public init(parser: LyricsParser, currentTime: Binding<TimeInterval>, isPlaying: Binding<Bool>, style: LyricItemStyle = LyricItemStyle()) {
        self.parser = parser
        self._currentTime = currentTime
        self._isPlaying = isPlaying
        self.style = style
    }

    // MARK: - Body

    public var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(Array(lyricsItems.enumerated()), id: \.offset) { index, item in
                    LyricItemView(
                        item: item,
                        highlighted: focusedLyricIdx == index,
                        font: style.font,
                        highlightedFont: style.highlightedFont,
                        textColor: style.textColor,
                        highlightedTextColor: style.highlightedTextColor
                    )
                    .id(index)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            .task {
                reloadLyricsItems()
            }
            .onReceive(timer) { _ in
                if isPlaying {
                    currentTime += 0.1
                }
            }
            .onChange(of: currentTime) { newValue in
                scroll(toTime: newValue, proxy: proxy, animated: true)
            }
        }
    }

    // MARK: - Private methods

    private func reloadLyricsItems() {
        lyricsItems = parser.lyrics
    }

    // MARK: - Controls

    @MainActor
    internal func scroll(toTime time: TimeInterval, proxy: ScrollViewProxy, animated: Bool) {
        guard !lyricsItems.isEmpty else {
            withAnimation(animated ? .easeInOut(duration: 0.3) : nil) {
                proxy.scrollTo(lyricsItems.indices.first, anchor: .center)
            }
            return
        }

        let index = lyricsItems.index(where: { $0.time >= time }) ?? lyricsItems.indices.last!
        focusedLyricIdx = index

        withAnimation(animated ? .easeInOut(duration: 0.3) : nil) {
            proxy.scrollTo(focusedLyricIdx, anchor: .center)
        }
    }
}

