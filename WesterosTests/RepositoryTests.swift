//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Alexandre Freire on 06/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Westeros
class RepositoryTests: XCTestCase {

    var houses: [House]!
    
    override func setUp() {
        houses = Repository.local.houses
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseExistence() {
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepository_HouseCount() {
        XCTAssertEqual(houses.count, 3)
    }

    func testLocalRepository_ReturnsSortedArrayOfHouses() {
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitively() {
        let stark: House = Repository.local.house(named: "stArk")!
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark.name, "Stark")
        
        let keepcodig: House = Repository.local.house(named: "Keepcoding")!
        XCTAssertNil(keepcodig)
    }
    
    func testLocalRepositoryHouseByNameSafety() {
        let houseName: String = Repository.local.house(named: "StaRk")!
        XCTAssertEqual(houseName, "Stark")
    }
    
    
    // given-when-then
    func testLocalRepository_HousesFilteredBy_ReturnsTheCorrectValue() {
//        let filtered = Repository.local.houses {
//            $0.count == 1
//        }
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })

        XCTAssertEqual(filtered.count, 1)
    }
}
