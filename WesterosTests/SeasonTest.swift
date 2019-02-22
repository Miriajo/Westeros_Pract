//
//  SeasonTest.swift
//  WesterosTests
//
//  Created by Casa on 21/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTest: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    
    var episodes: [Episode]!
    
    let dateStr1 = "17/04/2011"
    let dateStr2 = "01/04/2012"
    let formatter = DateFormatter()
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       // season = Season(season: 1, airedDate: Date("17-Abril-2011"))
        formatter.dateFormat = "dd/MM/yyyy"
        
        if let d = formatter.date(from: dateStr1) {
        
            season1 = Season(season: 1, airedDate: d, image: UIImage(named:"season1.jpg")!)
            
            episodes = [ Episode(episode: 1, title: "Winter Is Comming", airedDate: d, season: season1),
                         Episode(episode: 2, title: "The Kingsroad", airedDate: d, season: season1)
            ]
            
        }
        
        if let d = formatter.date(from: dateStr2) {
            season2 = Season(season: 1, airedDate: d, image: UIImage(named:"season2.jpg")!)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }

    func testSeasonAddEpisodes() {
        XCTAssertEqual(season1.count, 0)
        
        season1.add(episode: episodes[0])
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episodes[1])
        XCTAssertEqual(season1.count, 2)
    }
    
    
    func testSeasonAddEpisodesAtOnce() {
        season1.add(episodes: episodes)
        XCTAssertEqual(season1.count, 2)
    }
    
    func testSeasonStringConversion() {
        let customStr = "Season 1"
        XCTAssertEqual(season1.description, customStr)
    }
    
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let dateStr = formatter.date(from: "17/04/2011")!
        let jinxed = Season(season: 1, airedDate: dateStr, image: UIImage(named:"season1.jpg")!)
        XCTAssertEqual(season1, jinxed)
        
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
}
