//
//  SeasonTest.swift
//  WesterosTests
//
//  Created by Casa on 21/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTest: XCTestCase {
    
    var episodes: [Episode]!
    var season1: Season!
    
    let dateStr = "17-Abril-2011"
    let formatter = DateFormatter()
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // season = Season(season: 1, airedDate: Date("17-Abril-2011"))
        formatter.dateFormat = "dd-MMMM-yyyy"
     
        season1 = Season(season: 1, airedDate: formatter.date(from: dateStr)!)
        
        episodes = [ Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: dateStr)!, season: season1),
                     Episode(episode: 2, title: "The Kingsroad", airedDate: formatter.date(from: dateStr)!, season: season1)
        ]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEpisodesExistence() {
        XCTAssertNotNil(episodes)
    }
    
    
    // given - when - then
    func testEpisodeHashable() {
        XCTAssertNotNil(episodes[0].hashValue)
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(episodes[0], episodes[0])
        
        // Igualdad
        let ep1 = Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: dateStr)!, season: season1)
        XCTAssertEqual(ep1, episodes[0])
        
        // Desigualdad
        XCTAssertNotEqual(episodes[0], episodes[1])
    }
}
