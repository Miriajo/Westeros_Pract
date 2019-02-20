//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Casa on 20/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import XCTest


class SeasonTests: XCTestCase {

    var season: Season!
    var episodes: [Episode]!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        season = Season(seasonNum: "1", airedDate: Date)
        episodes = Episode(
            { episodeNum: "1", title: "Winter Is Coming", airedDate: "17 de abril de 2011" },
            { episodeNum: "2", title: "The Kingsroad", airedDate: "24 de abril de 2011" }
        )
        
    }

    override func tearDown() {
        // Put teardown code here. Thi1s method is called after the invocation of each test method in the class.
    }


}
