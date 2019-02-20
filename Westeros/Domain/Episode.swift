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
    let episodeNum: Int
    let title: String
    let airedDate: Date
    
    // MARK: Initialization
    init(episodeNum: Int, title: String, airedDate: Date) {
        self.episodeNum = episodeNum
        self.title = title
        self.airedDate = airedDate
    }
}
