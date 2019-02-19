//
//  PersonTests.swift
//  WesterosTests
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {

    var ned: Person!
    var arya: Person!
    var starkHouse: House!
    var starkSigil: Sigil!
    // 1- Le damos un valor por defecto
    // 2- La creo de tipo opcional, para que pueda ser nil
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonExistence() {
        XCTAssertNotNil(ned)
    }
    
    func testPersonHasFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
    
    // given - when - then
    func testPersonHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(ned, ned)
        
        // Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(eddard, ned)
        
        // Desigualdad
        XCTAssertNotEqual(ned, arya)
    }
}
