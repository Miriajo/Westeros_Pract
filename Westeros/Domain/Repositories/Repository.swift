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
    func house(named: String) -> String
    func houses(filteredBy filter: HouseFilter) -> [House]
    
    // MARK: Inizialization - Season
  //implementar las funciones y variables necesarias para Seasons
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get } // sólo get porque será de sólo lectura
    func season(number: Int) -> Season?
    func seasons(filteredBy filter: SeasonFilter) -> [Season]
   
}

final class LocalFactory: HouseFactory {

    enum Named: String {
        case stark = "Stark"
        case lannister = "Lannister"
        case targaryen = "Targaryen"
    }

    var houses: [House] {
        // Creación de casas
        let starkSigil = Sigil(image: UIImage(named: "stark_sigil")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister_sigil")!, description: "León Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryen_sigil")!, description: "Dragón tricéfalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", wikiURL: targaryenURL)
        
        // Añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse, image: UIImage(named:"robb")!)
        let arya = Person(name: "Arya", house: starkHouse, image: UIImage(named:"arya")!)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse, image: UIImage(named:"tyrion")!)
        let cersei = Person(name: "Cersei", house: lannisterHouse, image: UIImage(named:"cersei")!)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse, image: UIImage(named:"jaime")!)
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse, image: UIImage(named:"dany")!)
        
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
    
    func house(named name: String) -> String {
        
        switch name {
            case Named.stark.rawValue:
                return Named.stark.rawValue
            case Named.lannister.rawValue:
                return Named.lannister.rawValue
            case Named.targaryen.rawValue:
                return Named.lannister.rawValue
          
        default:
            return "nothing"
        }
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }

    
    var seasons: [Season] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
     
        // Creación de temporadas
        let season1 = Season(season: 1, airedDate: formatter.date(from: "17/04/2011")!, image: UIImage(named:"season1")!)
        let season2 = Season(season: 2, airedDate: formatter.date(from: "1/04/2012")!, image: UIImage(named: "season2")!)
        let season3 = Season(season: 3, airedDate: formatter.date(from: "31/03/2013")!, image: UIImage(named: "season3")!)
        let season4 = Season(season: 4, airedDate: formatter.date(from: "6/04/2014")!, image: UIImage(named: "season4")!)
        let season5 = Season(season: 5, airedDate: formatter.date(from: "12/04/2015")!, image: UIImage(named: "season5")!)
        let season6 = Season(season: 6, airedDate: formatter.date(from: "24/04/2016")!, image: UIImage(named: "season6")!)
        let season7 = Season(season: 7, airedDate: formatter.date(from: "16/07/2017")!, image: UIImage(named: "season7")!)


        // Creación de episodios diferentes temporadas
        let episode1 = [ Episode(episode: 1, title: "Winter Is Comming", airedDate: formatter.date(from: "17/04/2011")!, summary: "In the Seven Kingdoms of Westeros, a soldier of the ancient Night's Watch order survives an attack by supernatural creatures known as the White Walkers, thought until now to be myth. He rushes to Castle Winterfell, which is ruled by Eddard 'Ned' Stark, Warden of the North, who decapitates the soldier for deserting his post. In King's Landing, the capital, Jon Arryn, the 'Hand of the King', dies under mysterious circumstances. King Robert Baratheon, Ned's longtime friend, travels to Winterfell, offering the position to him and also proposing marriage between his firstborn son Joffrey and Ned's older daughter Sansa. Ned's wife Catelyn receives a letter from her sister Lysa, Jon Arryn's widow, saying that she has escaped King's Landing and that Jon was murdered by the Lannisters, Queen Cersei's family. Catelyn burns the letter and tells Ned about it, believing that the Lannisters are plotting against Robert. Ned's 10-year-old son, Brandon, climbs a tower, where he witnesses Cersei having sex with her twin brother, Jaime, who then pushes him out the window from a presumably fatal height. Meanwhile across the narrow sea in Essos, the exiled Prince Viserys Targaryen makes a deal with the Dothraki warlord Khal Drogo, who marries Viserys' younger sister, Daenerys, in exchange for an army to conquer Westeros and reclaim the Iron Throne.", season: season1),
                         Episode(episode: 2, title: "The Kingsroad", airedDate: formatter.date(from: "24/04/2011")!, summary: "Having accepted his new role as the Hand of the King, Ned leaves Winterfell with his daughters Sansa and Arya, while Catelyn stays behind to tend to Bran. The unconscious Bran is attacked by an assassin, but his direwolf saves him. Catelyn decides to go to King's Landing to tell Ned about the attempt and suspected Lannister involvement. Jon Snow, Ned's illegitimate son, heads north to join the brotherhood of the Night's Watch, protectors of the Wall that keeps the White Walkers and the wildlings from entering civilized Westeros. Tyrion, Cersei's brother, decides to forgo the trip south with his family and instead accompanies Snow's entourage to the Wall. When Joffrey threatens Arya and her friend, Arya's direwolf defends her and escapes, provoking a conflict between the Starks and the Lannisters. To resolve the insult, Cersei demands that Robert order Ned to execute Sansa's direwolf. In Winterfell, Brandon awakens from unconsciousness. Meanwhile, Daenerys focuses her attention on learning how to please Drogo.", season: season1)
        ]
        let episode2 = [ Episode(episode: 1, title: "The North Remembers", airedDate: formatter.date(from: "1/04/2012")!, summary: "To Cersei's dismay, Tyrion takes up his post as acting Hand at King's Landing. At Dragonstone, Stannis proclaims allegiance to Melisandre's new god and lays public claim to the Iron Throne, revealing Joffrey's bastardy. The latter orders the soldiers to slaughter Robert's bastards, one of whom, named Gendry, manages to escape King's Landing along with Arya. Having won three victories, Robb offers the Lannisters peace in exchange for the North's independence and Sansa's return, sending Theon to gain the support of Balon, his father, and Catelyn to seek alliance with Renly, who also claims the throne. Beyond the Wall, the Night's Watch finds shelter with Craster and his daughters/wives. In Essos, as her people slowly die in the Red Waste, Daenerys sends out riders for reconnaissance.", season: season2),
                         Episode(episode: 2, title: "The Night Lands", airedDate: formatter.date(from: "8/04/2012")!, summary: "Returning to his home of Pyke after nine years as the Starks' ward, Theon is reunited with his sister, Yara, and Balon, who despises Theon for his Northern ways and intends to win back his crown by force. Cersei rejects Robb's terms and Tyrion exiles Slynt, head of the Gold Cloaks, to the Wall, promoting Bronn to commander of the watch. On the road to the Wall, Arya reveals her true identity to Gendry. North of the Wall, Tarly is approached by one of Craster's daughters, Gilly, who is pregnant and fears for her unborn son; Snow is reluctant to help her despite Tarly's pleas. In the Red Waste, one of the horses returns to Daenerys with the severed head of its rider in a pouch, a message from one of her enemies. In Dragonstone, Davos, Stannis's henchman, recruits the pirate Salladhor Saan to Stannis' side, and the latter has sex with Melisandre to obtain the son his wife cannot give him. Snow discovers that Craster sacrifices his sons to the White Walkers; in response, Craster knocks Snow unconscious.", season: season2)
        ]
        let episode3 = [ Episode(episode: 1, title: "Valar Dohaeris", airedDate: formatter.date(from: "31/03/2013")!, summary: "Some of the Night's Watchmen, including Tarly and Mormont, survive the White Walkers' attack and pledge to return to the Wall to warn the Seven Kingdoms. Snow is brought before Rayder, the 'King beyond the Wall', and pledges his loyalty to the Wildlings. A scarred Tyrion tries to get Casterly Rock from Tywin, who promises other things instead. Margaery engages in charity work with the orphans of King's Landing. Baelish offers to help Sansa escape King's Landing. Ros advises Shae not to trust him. Davos is rescued by Saan, who does not want any more connections with Stannis, and returns to Dragonstone, where he unsuccessfully tries to kill Melisandre, who blames him for convincing Stannis not to let her join the battle, and is imprisoned. In Essos, Daenerys arrives in the city of Astapor to buy an army of brutally-trained slave soldiers, the 'Unsullied'. The warlocks of Qarth attempt to assassinate her, but she is saved by Selmy, the former Kingsguard commander, who pledges his loyalty.", season: season3),
                         Episode(episode: 2, title: "Dark Wings", airedDate: formatter.date(from: "7/04/2013")!, summary: "Brienne continues escorting Jaime across the Riverlands to King's Landing. He engages her in a fight, which is interrupted by Bolton soldiers. After receiving the news of the sack of Winterfell and the disappearance of Bran and Rickon, Robb diverts his attentions from the war against the Lannisters to attend Catelyn's father's funeral in Riverrun, angering Karstark, who seeks vengeance for his sons who were killed by the Lannisters. Arya, Gendry and Hot Pie also make for Riverrun, but are waylaid by a rebel group, the 'Brotherhood without Banners', and are taken to an inn, where the captured Clegane reveals Arya's identity. Margaery and her grandmother Olenna, the 'Queen of Thorns', convince Sansa to tell them about Joffrey's flawed character. Theon is tortured by unknown captors. Bran, Rickon, Osha and Hodor encounter the siblings Jojen and Meera, children of the Stark bannerman Howland. Jojen, who has been sharing Bran's strange dreams, tells him that he is a warg, able to enter the minds of animals.", season: season3)
        ]
        let episode4 = [ Episode(episode: 1, title: "Two Swords", airedDate: formatter.date(from: "6/04/2014")!, summary: "Tywin oversees the reforging of Ice, the Stark ancestral sword, into two new swords, one for Jaime, who tries to deal with the loss of his sword hand and Cersei's love, and one for King Joffrey as a wedding present. Prince Oberyn Martell, on behalf of his brother, Prince Doran of Dorne, arrives in King's Landing with his paramour, Ellaria Sand, to attend the royal wedding and is welcomed by Tyrion. Oberyn openly reveals to Tyrion his motive for his visit: revenge against the Lannisters for the rape and murder of his sister, Elia, wife of Prince Rhaegar. In the North, while Styr and his group of cannibal Thenns reinforce Tormund, Ygritte, and the other wildlings, Jon is released by Maester Aemon after confessing what he did during his time with the wildlings to gain information. In the Riverlands, Arya and the Hound reclaim her sword, Needle, from Polliver, killing him and his men. In Essos, Daenerys leads her army on a march towards Meereen, the last of the three great slave cities, though she is troubled by how her dragons are becoming less tame as they grow.", season: season4),
                         Episode(episode: 2, title: "The Lion and the Rose", airedDate: formatter.date(from: "13/04/2014")!, summary: "Roose Bolton returns to the Dreadfort, where he criticizes Ramsay for mistreating Theon, who has been brutalized into a subservient persona called 'Reek'. Roose decides to find and kill the remaining Stark children, Bran and Rickon, who threaten the legitimacy of his new title. He orders Ramsay to reclaim the territories under Ironborn occupation. In Dragonstone, Melisandre orders several people to be burned as a tribute to the Lord of Light, to the delight of Queen Selyse and the disgust of Davos and Shireen. In King's Landing, Tyrion ends his relationship with Shae to protect her from his family and has her shipped off to Pentos. Jaime begins training his left-handed swordplay with the help of Bronn. King Joffrey and Margaery Tyrell are wed. Later, at the Royal Wedding feast, tensions between Joffrey and Tyrion grow—just before the former succumbs to poisoned wine and dies. A grief-stricken Cersei accuses Tyrion of the murder and has him arrested, while Ser Dontos, a former knight, advises Sansa to leave with him in order to survive.", season: season4)
        ]
        let episode5 = [ Episode(episode: 1, title: "The Wars to Come", airedDate: formatter.date(from: "12/04/2015")!, summary: "In a flashback, a witch tells a teenage Cersei that someone younger and more beautiful than herself will one day steal her accomplishments. In the present, Tywin is buried and Lancel returns, now a devoutly religious man and a member of the 'Sparrows'. In Pentos, a despondent Tyrion agrees to accompany Varys to Meereen to support Daenerys's claim on the Iron Throne. In Meereen, the insurgent 'Sons of the Harpy' murder an Unsullied, forcing Daenerys to launch more restrictive measures without respecting the old traditions. Missandei gets suspicious when she realizes that the Unsullied visit brothels. Daenerys's locked-away dragons attack her when she checks on them. In the Vale, Baelish puts Robin in the care of House Royce and leaves with Sansa. At the Wall, Stannis seeks to enlist the Wildlings in his war against Roose. Jon Snow is unable to convince Rayder to accept Stannis's authority. When the latter has Mance burned alive, Jon Snow ends his suffering with an arrow to the heart.", season: season5),
                         Episode(episode: 2, title: "The House of Black and White", airedDate: formatter.date(from: "19/04/2015")!, summary: "Arya arrives in Braavos and is accepted into the 'House of Black and White' by H'ghar, who calls himself and his colleagues 'no one'. Jaime tells Cersei he is going to Dorne to sneak out Myrcella, who is promised to Prince Doran's son, and recruits Bronn to assist him; Podrick recognises Baelish and Sansa in a tavern; Brienne offers Sansa her protection, but is rebuffed. Baelish insists Brienne stay with them, but she refuses and escapes with Podrick. However, she decides to follow Sansa secretly. Stannis offers Snow legitimacy and lordship of Winterfell if he leaves the Night's Watch to help him, but Snow declines; Tarly nominates him as a candidate for Lord Commander, and he is elected by the casting vote of Aemon. Daenerys faces a riot after she decides to execute a former slave who murdered a captured member of the Sons of the Harpy before he could be tried. Drogon reappears to her, but leaves again.", season: season5)
        ]
        let episode6 = [ Episode(episode: 1, title: "The Red Woman", airedDate: formatter.date(from: "24/04/2016")!, summary: "Jon Snow's corpse is found by Ser Davos, Edd and a few other loyalists; Davos and the others take him inside and lock themselves behind a door with him, while Edd goes to get help. Thorne assumes command of the Watch. At Winterfell, Ramsay mourns for Myranda, while Sansa and Theon escape through the woods. Ramsay's men catch up with them, and are about to take them captive, when Brienne and Pod arrive, kill the men, and the former is accepted into Sansa's service. In King's Landing, Cersei receives Jaime, who arrives with Myrcella's body. Jaime promises Cersei they will take their revenge. Obara and Nymeria murder Trystane, on his way home from King's Landing, while in Sunspear, Doran and Areo Hotah are killed by Ellaria and Tyene, after the former learns of Myrcella's death. In Meereen, Tyrion and Varys find all the ships burning in the harbor. Jorah and Daario continue to track Daenerys, who is taken by the Dothraki to Khal Moro. In Braavos, Arya lives on the streets as a beggar, where she is beaten by the Waif. In her chamber, Melisandre removes her bejeweled necklace as she reveals her true appearance as an old crone.", season: season6),
                         Episode(episode: 2, title: "Home", airedDate: formatter.date(from: "1/05/2016")!, summary: "Brandon visits Winterfell in a vision of the past, and sees Eddard, Benjen, and their sister Lyanna, as well as a young Hodor. Edd arrives with Tormund and a group of Wildlings, imprisoning Thorne and the other mutineers. Tommen asks Cersei to teach him to be strong. Tyrion learns that Astapor and Yunkai have reverted to slavery, and releases Rhaegal and Viserion from their chains. In Braavos, Arya is attacked by the Waif before H'ghar appears and recruits her again. Walda, Roose's wife, gives birth to a boy, prompting Ramsay to murder Roose, her, and the baby. Brienne reveals to Sansa that Arya is still alive. Sansa permits Theon's return to the Iron Islands, where his uncle Euron reappears and murders King Balon. Davos persuades Melisandre to attempt to resurrect Jon. At first, her attempts seem to fail. However, once everyone leaves the room, he awakens.", season: season6)
        ]
        let episode7 = [ Episode(episode: 1, title: "Dragonstone", airedDate: formatter.date(from: "16/07/2017")!, summary: "At the Twins, the remaining lords of House Frey are poisoned by Arya, disguised as Walder Frey. The White Walkers march toward the Wall, where Tollett allows Bran and Meera inside. At Winterfell, despite Sansa's disapproval, Jon secures the loyalties of Houses Umber and Karstark, who fought alongside Ramsay in the Battle of the Bastards. At the Citadel, Samwell steals books that reveal a large reservoir of dragonglass in Dragonstone, and sends word to Jon. He later finds Jorah in a cell. In the Riverlands, Arya meets a group of friendly Lannister soldiers, who take her intention to kill Cersei as a joke. Thoros shows Sandor a vision in the fire. The revelation leads him to believe in the Lord of Light. In King's Landing, Jaime tells Cersei of the crucial need for allies. She welcomes Euron, who proposes marriage to her in exchange for his Iron Fleet and a chance to kill Theon and Yara. Cersei declines, citing trust as a concern, so Euron promises to return with a 'gift' to prove his loyalty. Daenerys arrives at Dragonstone, the home of House Targaryen once occupied by Stannis, with her army and dragons.", season: season7),
                         Episode(episode: 2, title: "Stormborn", airedDate: formatter.date(from: "23/07/2017")!, summary: "Daenerys sends the Dornishmen with Yara's fleet to Sunspear and the Unsullied to Casterly Rock, deciding to place King's Landing under siege. She questions Varys' loyalty and threatens to burn him alive if he ever betrays her. Melisandre arrives and encourages her to invite Jon Snow to Dragonstone. Grey Worm and Missandei consummate their relationship. Cersei gathers several lords, asking for their fealties and elevating Randyll Tarly as Warden of the South. Qyburn shows Cersei a prototype ballista capable of harming dragons. Arya meets with Hot Pie and learns of Jon's ascension to King in the North, halting plans to travel to King's Landing and instead setting course for Winterfell. After receiving Samwell's letter, Jon leaves for Dragonstone in hopes of convincing Daenerys to support the fight against the White Walkers. He leaves Sansa in charge and aggressively warns Littlefinger to keep his distance. Samwell applies a forbidden treatment on Jorah's greyscale infection. Euron's fleet attacks Yara's. Obara and Nymeria are killed, while Ellaria, Tyene, and Yara are captured. Theon shows flashes of his time as Reek, hesitating to challenge Euron before fleeing the carnage by jumping into the sea.", season: season7)
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

