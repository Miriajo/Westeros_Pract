//
//  Season.swift
//  Westeros
//
//  Created by Casa on 20/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import Foundation


final class Season {
    
    // MARK: Properties
    let seasonNum: Int
    let airedDate: Date
    private var _episodes: Members
    
    // MARK: Inizialization
    init(seasonNum: Int, airedDate: Date) {
        self.seasonNum = seasonNum
        self.airedDate = airedDate
        _episodes = Members()
    }
}
