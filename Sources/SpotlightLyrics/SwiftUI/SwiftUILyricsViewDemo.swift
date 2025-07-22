//
//  SwiftUILyricsViewDemo.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017 Scott Rong. All rights reserved.
//

import SwiftUI

public struct SwiftUILyricsViewDemo: View {
    @State private var currentTime: TimeInterval = 0
    @State private var isPlaying = false

    private let sampleLyrics = """
[ti:Sample Song]
[ar:Sample Artist]
[al:Sample Album]
[00:00.00]This is a sample song
[00:03.00]With some sample lyrics
[00:06.00]To demonstrate the SwiftUI lyrics view
[00:09.00]It should scroll automatically
[00:12.00]As the timer progresses
[00:15.00]And highlight the current line
[00:18.00]Just like the original UIKit version
[00:21.00]But now it's built with SwiftUI
[00:24.00]Using ScrollViewReader for smooth scrolling
[00:27.00]And ObservableObject for reactive updates
"""

    public init() {}

    public var body: some View {
        VStack {
            Text("SwiftUI Lyrics View Demo")
                .font(.title)
                .padding()

            SwiftUILyricsView(
                parser: LyricsParser(lyrics: sampleLyrics),
                currentTime: $currentTime,
                isPlaying: $isPlaying
            )
                .frame(height: 300)

            VStack(spacing: 20) {
                Text("Current Time: \(String(format: "%.1f", currentTime))s")
                    .font(.headline)

                HStack(spacing: 20) {
                    Button(isPlaying ? "Pause" : "Play") {
                        isPlaying.toggle()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Reset") {
                        currentTime = 0
                        isPlaying = false
                    }
                    .buttonStyle(.bordered)
                }

                Slider(value: $currentTime, in: 0...30, step: 0.1)
            }
            .padding()
        }
    }
}
 
#Preview {
    SwiftUILyricsViewDemo()
}
