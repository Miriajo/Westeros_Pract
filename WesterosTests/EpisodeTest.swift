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
            season1 = Season(season: 1, airedDate: d, image: UIImage(named:"season1.jpg")!)
            
            episodes = [ Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: "17/04/2011")!, summary: "In the Seven Kingdoms of Westeros, a soldier of the ancient Night's Watch order survives an attack by supernatural creatures known as the White Walkers, thought until now to be myth. He rushes to Castle Winterfell, which is ruled by Eddard 'Ned' Stark, Warden of the North, who decapitates the soldier for deserting his post. In King's Landing, the capital, Jon Arryn, the 'Hand of the King', dies under mysterious circumstances. King Robert Baratheon, Ned's longtime friend, travels to Winterfell, offering the position to him and also proposing marriage between his firstborn son Joffrey and Ned's older daughter Sansa. Ned's wife Catelyn receives a letter from her sister Lysa, Jon Arryn's widow, saying that she has escaped King's Landing and that Jon was murdered by the Lannisters, Queen Cersei's family. Catelyn burns the letter and tells Ned about it, believing that the Lannisters are plotting against Robert. Ned's 10-year-old son, Brandon, climbs a tower, where he witnesses Cersei having sex with her twin brother, Jaime, who then pushes him out the window from a presumably fatal height. Meanwhile across the narrow sea in Essos, the exiled Prince Viserys Targaryen makes a deal with the Dothraki warlord Khal Drogo, who marries Viserys' younger sister, Daenerys, in exchange for an army to conquer Westeros and reclaim the Iron Throne.", season: season1),
                         Episode(episode: 2, title: "The Kingsroad", airedDate: formatter.date(from: "24/04/2011")!, summary: "Having accepted his new role as the Hand of the King, Ned leaves Winterfell with his daughters Sansa and Arya, while Catelyn stays behind to tend to Bran. The unconscious Bran is attacked by an assassin, but his direwolf saves him. Catelyn decides to go to King's Landing to tell Ned about the attempt and suspected Lannister involvement. Jon Snow, Ned's illegitimate son, heads north to join the brotherhood of the Night's Watch, protectors of the Wall that keeps the White Walkers and the wildlings from entering civilized Westeros. Tyrion, Cersei's brother, decides to forgo the trip south with his family and instead accompanies Snow's entourage to the Wall. When Joffrey threatens Arya and her friend, Arya's direwolf defends her and escapes, provoking a conflict between the Starks and the Lannisters. To resolve the insult, Cersei demands that Robert order Ned to execute Sansa's direwolf. In Winterfell, Brandon awakens from unconsciousness. Meanwhile, Daenerys focuses her attention on learning how to please Drogo.", season: season1)
            ]
            
            print("Episodio 1: ", episodes[0].title)
            
           
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
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episodes[0], episodes[0])
        
        // Igualdad
        let ep1 = Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: dateStr)!, summary: "In the Seven Kingdoms of Westeros, a soldier of the ancient Night's Watch order survives an attack by supernatural creatures known as the White Walkers, thought until now to be myth. He rushes to Castle Winterfell, which is ruled by Eddard 'Ned' Stark, Warden of the North, who decapitates the soldier for deserting his post. In King's Landing, the capital, Jon Arryn, the 'Hand of the King', dies under mysterious circumstances. King Robert Baratheon, Ned's longtime friend, travels to Winterfell, offering the position to him and also proposing marriage between his firstborn son Joffrey and Ned's older daughter Sansa. Ned's wife Catelyn receives a letter from her sister Lysa, Jon Arryn's widow, saying that she has escaped King's Landing and that Jon was murdered by the Lannisters, Queen Cersei's family. Catelyn burns the letter and tells Ned about it, believing that the Lannisters are plotting against Robert. Ned's 10-year-old son, Brandon, climbs a tower, where he witnesses Cersei having sex with her twin brother, Jaime, who then pushes him out the window from a presumably fatal height. Meanwhile across the narrow sea in Essos, the exiled Prince Viserys Targaryen makes a deal with the Dothraki warlord Khal Drogo, who marries Viserys' younger sister, Daenerys, in exchange for an army to conquer Westeros and reclaim the Iron Throne.", season: season1)
        XCTAssertEqual(ep1, episodes[0])
        
        // Desigualdad
        XCTAssertNotEqual(episodes[0], episodes[1])
    }
    
        func testEpisodeComparison() {
        XCTAssertLessThan(episodes[0], episodes[1])
    }
}
