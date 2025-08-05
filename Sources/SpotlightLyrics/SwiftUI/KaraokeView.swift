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
    @State private var schedulerTask: Task<Void, Never>?

    private let style: LyricItemStyle
    private let parser: LyricsParser

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
//                .scrollTargetLayout()
            }
//            .scrollPosition(id: $focusedLyricIdx, anchor: .center)
            .listStyle(PlainListStyle())
            .task {
                reloadLyricsItems()
            }
            .onChange(of: isPlaying) { newValue in
                if newValue {
                    scheduleNextLyric(proxy: proxy)
                } else {
                    schedulerTask?.cancel()
                }
            }
            .onChange(of: currentTime) { newValue in
                scroll(toTime: newValue, proxy: proxy)
            }
        }
    }

    // MARK: - Private methods

    private func reloadLyricsItems() {
        lyricsItems = parser.lyrics
    }

    // MARK: - Controls

    private func scheduleNextLyric(proxy: ScrollViewProxy) {
        // Cancel any existing task
        schedulerTask?.cancel()

        guard !lyricsItems.isEmpty, isPlaying else { return }

        if focusedLyricIdx == nil {
            scroll(toIndex: 0, proxy: proxy)
        }

        print("LYRIC ITEMS FIRST 4: \(lyricsItems.prefix(4))")

        // Find the next lyric based on current time
        let nextIndex = lyricsItems.firstIndex(where: { $0.time > currentTime }) ?? lyricsItems.indices.last!
        let nextLyric = lyricsItems[nextIndex]

        schedulerTask = Task { @MainActor in
            // Calculate wait time until next lyric
            let waitTime = nextLyric.time - currentTime

            if waitTime > 0 {
                // Sleep until just before the next lyric (50ms buffer)
                try? await Task.sleep(for: .seconds(max(0, waitTime - 0.1)))

                // Check if we're still playing and task wasn't cancelled
                if isPlaying && !Task.isCancelled {
                    currentTime = nextLyric.time
                    scroll(toIndex: nextIndex, proxy: proxy)

                    // Schedule the next lyric if there is one
                    if nextIndex < lyricsItems.count - 1 {
                        scheduleNextLyric(proxy: proxy)
                    }
                }
            }
        }
    }

    @MainActor
    private func scroll(toIndex index: Int, proxy: ScrollViewProxy) {
        focusedLyricIdx = index
        withAnimation(.easeInOut(duration: 0.3)) {
            proxy.scrollTo(index, anchor: .center)
        }
    }

    @MainActor
    internal func scroll(toTime time: TimeInterval, proxy: ScrollViewProxy) {
        guard !lyricsItems.isEmpty else {
            scroll(toIndex: 0, proxy: proxy)
            return
        }

        let index = lyricsItems.firstIndex(where: { $0.time >= time }) ?? lyricsItems.indices.last!
        scroll(toIndex: index, proxy: proxy)

        // If we're playing, schedule the next lyric
        if isPlaying {
            scheduleNextLyric(proxy: proxy)
        }
    }
}

