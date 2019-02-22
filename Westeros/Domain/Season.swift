//
//  Season.swift
//  Westeros
//
//  Created by Casa on 20/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

typealias Episodes = Set<Episode>

final class Season {
    
    // MARK: Properties
    let season: Int
    let airedDate: Date
    let image: UIImage
    private var _episodes: Episodes
    
    // MARK: Inizialization
    init(season: Int, airedDate: Date, image: UIImage) {
        self.season = season
        self.airedDate = airedDate
        self.image = image
        _episodes = Episodes()
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
        
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
   func add(episode: Episode) {
        guard episode.season == self else { return }
        _episodes.insert(episode)
    }
    
    // Función variádica
    func add(episodes: [Episode]) {
        episodes.forEach { add(episode: $0) }
    }
}


extension Season {
    var proxyForEquality: String {
        return "\(season) \(airedDate) \(count)"
    }
    
    var proxyForComparison: Date {
        return airedDate
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        return "Season \(season)"
    }
    
    var episodesCount: String {
        return "\(_episodes.count) Episodes"
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        let d1: Date = lhs.proxyForComparison
        let d2: Date = rhs.proxyForComparison
        
        return d1 < d2
    }
}

