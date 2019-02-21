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
    
    var season1: Season!
    
    var episodes: [Episode]!
    
    let dateStr = "04/17/2011"
    let formatter = DateFormatter()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // season = Season(season: 1, airedDate: Date("17-Abril-2011"))
        formatter.dateFormat = "MM/dd/yyyy"
        
        if let d = formatter.date(from: dateStr) {
            season1 = Season(season: 1, airedDate: d)
            
            episodes = [ Episode(episode: 1, title: "Winter Is Comming", airedDate: d, season: season1),
                         Episode(episode: 2, title: "The Kingsroad", airedDate: d, season: season1)
            ]
            
            print("Episodio 1: ", episodes[0].title)
            
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM dd, y"
            print(displayFormatter.string(from: d))
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEpisodesExistence() {
        XCTAssertNotNil(episodes)
    }
    
    func testEpisodeStringConversion() {
        let customStr = "Episode 1"
        XCTAssertEqual(episodes[0].description, customStr)
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
