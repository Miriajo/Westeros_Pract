//
//  Repository.swift
//  Westeros
//
//  Created by Alexandre Freire on 06/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    var houses: [House] { get } // sólo get porque será de sólo lectura
    func house(named: String) -> House?
    func houses(filteredBy filter: HouseFilter) -> [House]
    
    // MARK: Inizialization - Season
  //implementar las funciones y variables necesarias para Seasons
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get } // sólo get porque será de sólo lectura
    func season(number: Int) -> Season?
    func seasons(filteredBy filter: SeasonFilter) -> [Season]

}

final class LocalFactory: HouseFactory {


    var houses: [House] {
        // Creación de casas
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall")!, description: "Dragón tricéfalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", wikiURL: targaryenURL)
        
        // Añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(person: dani)
        
        return [targaryenHouse, starkHouse, lannisterHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        //let house = houses.filter{ $0.name == name }.first
        let house = houses.first{ $0.name.uppercased() == name.uppercased() } // Con uppercased() "normalizamos los valores"
        return house
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }

    
    var seasons: [Season] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
     
        // Creación de temporadas
        let season1 = Season(season: 1, airedDate: formatter.date(from: "17/04/2011")!, image: UIImage(named:"season1.jpg")!)
        let season2 = Season(season: 2, airedDate: formatter.date(from: "1/04/2012")!, image: UIImage(named: "season2.jpg")!)
        let season3 = Season(season: 3, airedDate: formatter.date(from: "31/03/2013")!, image: UIImage(named: "season3.jpg")!)
        let season4 = Season(season: 4, airedDate: formatter.date(from: "6/04/2014")!, image: UIImage(named: "season4.jpg")!)
        let season5 = Season(season: 5, airedDate: formatter.date(from: "12/04/2015")!, image: UIImage(named: "season5.jpg")!)
        let season6 = Season(season: 6, airedDate: formatter.date(from: "24/04/2016")!, image: UIImage(named: "season6.jpg")!)
        let season7 = Season(season: 7, airedDate: formatter.date(from: "16/07/2017")!, image: UIImage(named: "season7.jpg")!)


        // Creación de episodios diferentes temporadas
        let episode1 = [ Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: "17/04/2011")!, season: season1),
                         Episode(episode: 2, title: "The Kingsroad", airedDate: formatter.date(from: "24/04/2011")!, season: season1)
        ]
        let episode2 = [ Episode(episode: 1, title: "The North Remembers", airedDate: formatter.date(from: "1/04/2012")!, season: season2),
                         Episode(episode: 2, title: "The Night Lands", airedDate: formatter.date(from: "8/04/2012")!, season: season2)
        ]
        let episode3 = [ Episode(episode: 1, title: "Valar Dohaeris", airedDate: formatter.date(from: "31/03/2013")!, season: season3),
                         Episode(episode: 2, title: "Dark Wings", airedDate: formatter.date(from: "7/04/2013")!, season: season3)
        ]
        let episode4 = [ Episode(episode: 1, title: "Two Swords", airedDate: formatter.date(from: "6/04/2014")!, season: season4),
                         Episode(episode: 2, title: "The Lion and the Rose", airedDate: formatter.date(from: "13/04/2014")!, season: season4)
        ]
        let episode5 = [ Episode(episode: 1, title: "The Wars to Come", airedDate: formatter.date(from: "12/04/2015")!, season: season5),
                         Episode(episode: 2, title: "The House of Black and White", airedDate: formatter.date(from: "19/04/2015")!, season: season5)
        ]
        let episode6 = [ Episode(episode: 1, title: "The Red Woman", airedDate: formatter.date(from: "24/04/2016")!, season: season6),
                         Episode(episode: 2, title: "Home", airedDate: formatter.date(from: "1/05/2016")!, season: season6)
        ]
        let episode7 = [ Episode(episode: 1, title: "Dragonstone", airedDate: formatter.date(from: "16/07/2017")!, season: season7),
                         Episode(episode: 2, title: "Stormborn", airedDate: formatter.date(from: "23/07/2017")!, season: season7)
        ]
        
        season1.add(episodes: episode1)
        season2.add(episodes: episode2)
        season3.add(episodes: episode3)
        season4.add(episodes: episode4)
        season5.add(episodes: episode5)
        season6.add(episodes: episode6)
        season7.add(episodes: episode7)

        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }
    
    func season(number: Int) -> Season? {
        let season = seasons.first{ $0.season == number }
        return season
    }
    
    func seasons(filteredBy filter: (Season) -> Bool) -> [Season] {
        return seasons.filter(filter)
    }
  
    
}

