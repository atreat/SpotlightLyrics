//
//  LyricsError.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017 Scott Rong. All rights reserved.
//

import Foundation


public struct LyricsItem {

    public init(time: TimeInterval, text: String = "") {
        self.time = time
        self.text = text
    }

    public var time: TimeInterval
    public var text: String
}

extension LyricsItem: Hashable { }

extension LyricsItem: Identifiable {
    public var id: TimeInterval {
        return time
    }
}
