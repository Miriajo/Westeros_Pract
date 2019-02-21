//
//  Season.swift
//  Westeros
//
//  Created by Casa on 20/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    
    // MARK: Properties
    let season: Int
    let airedDate: Date
    private var _episodes: Episodes
    
    // MARK: Inizialization
    init(season: Int, airedDate: Date) {
        self.season = season
        self.airedDate = airedDate
        _episodes = Episodes()
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
   func add(episode: Episode) {
        guard episode.season == self else { return }
        _episodes.insert(episode)
    }
    
    // Función variádica
    func add(episodes: Episode...) {
        //        for person in persons {
        //            add(person: person)
        //        }
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
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
