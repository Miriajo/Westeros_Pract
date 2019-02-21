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
    
    var episode1: Episode!
    var episode2: Episode!
    
    let dateStr1 = "17-Abril-2011"
    let dateStr2 = "1-Abril-2012"
    let formatter = DateFormatter()
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       // season = Season(season: 1, airedDate: Date("17-Abril-2011"))
        formatter.dateFormat = "dd-MMMM-yyyy"
        
        season1 = Season(season: 1, airedDate: formatter.date(from: dateStr1)!)
        season2 = Season(season: 1, airedDate: formatter.date(from: dateStr2)!)
        
        episode1 = Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: dateStr1)!, season: season1)
        episode2 = Episode(episode: 2, title: "The Kingsroad", airedDate: formatter.date(from: dateStr1)!, season: season1)
     
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }

    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
    }
    
    func testSeasonAddEpisodes() {
        XCTAssertEqual(season1.count, 0)
        
        season1.add(episode: episode1)
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode2)
        XCTAssertEqual(season1.count, 2)
    }
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let dateStr = formatter.date(from: "17-Abril-2011")!
        let jinxed = Season(season: 1, airedDate: dateStr)
        XCTAssertEqual(season1, jinxed)
        
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testHouseHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(season2, season1)
    }
    
}