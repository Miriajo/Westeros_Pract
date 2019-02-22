//
//  Episode.swift
//  Westeros
//
//  Created by Casa on 20/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import Foundation


final class Episode {
    
    // MARK: Properties
    weak var season: Season?
    let episode: Int
    let title: String
    let airedDate: Date
    let summary: String
    
    // MARK: Initialization
    init(episode: Int, title: String, airedDate: Date, summary: String) {
        self.episode = episode
        self.title = title
        self.airedDate = airedDate
        self.summary = summary
    }
    
    init(episode: Int, title: String, airedDate: Date, summary: String, season: Season) {
        self.episode = episode
        self.title = title
        self.airedDate = airedDate
        self.summary = summary
        self.season = season
    }
    
}

extension Episode {
    var proxyForEquality: String {
        return "\(season!.season) \(episode) \(title) \(airedDate)"
    }
    
    var proxyForComparison: Date {
        return airedDate
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "Episode \(episode)"
    }
    
}

// Si dos objetos tienen el mismo hash, significa que tienen que ser iguales
// A la inversa no es necesariamente cierta: 2 objecos puedes ser iguales y no tener el mismo hash
extension Episode: Hashable { // Identidad
    // Con proxy, le pasamos el marrón de calcular el hash u otra cosa a otro objeto
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        let d1: Date = lhs.proxyForComparison
        let d2: Date = rhs.proxyForComparison
        
        return d1 < d2
    }
}
