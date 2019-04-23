//
//  Universe.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/10/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation

// MARK: Singleton Class
class Universe {
    
    private static var universe: Universe {
        
        Universe.generateUniverse()
        return Universe()
    }
    
    private static var names: [String] = [
        "Acamar",
        "Adahn",
        "Aldea",
        "Andevian",
        "Antedi",
        "Balosnee",
        "Baratas",
        "Brax",
        "Bretel",
        "Calondia",
        "Campor",
        "Capelle",
        "Carzon",
        "Castor",
        "Cestus",
        "Cheron",
        "Courteney",
        "Daled",
        "Damast",
        "Davlos",
        "Deneb",
        "Deneva",
        "Devidia",
        "Draylon",
        "Drema",
        "Endor",
        "Esmee",
        "Exo",
        "Ferris",
        "Festen",
        "Fourmi",
        "Frolix",
        "Gemulon",
        "Guinifer",
        "Hades",
        "Hamlet",
        "Helena",
        "Hulst",
        "Iodine",
        "Iralius",
        "Janus",
        "Japori",
        "Jarada",
        "Jason",
        "Kaylon",
        "Khefka",
        "Kira",
        "Klaatu",
        "Klaestron",
        "Korma",
        "Kravat",
        "Krios",
        "Laertes",
        "Largo",
        "Lave",
        "Ligon",
        "Lowry",
        "Magrat",
        "Malcoria",
        "Melina",
        "Mentar",
        "Merik",
        "Mintaka",
        "Montor",
        "Mordan",
        "Myrthe",
        "Nelvana",
        "Nix",
        "Nyle",
        "Odet",
        "Og",
        "Omega",
        "Omphalos",
        "Orias",
        "Othello",
        "Parade",
        "Penthara",
        "Picard",
        "Pollux",
        "Quator",
        "Rakhar",
        "Ran",
        "Regulas",
        "Relva",
        "Rhymus",
        "Rochani",
        "Rubicum",
        "Rutia",
        "Sarpeidon",
        "Sefalla",
        "Seltrice",
        "Sigma",
        "Sol",
        "Somari",
        "Stakoron",
        "Styris",
        "Talani",
        "Tamus",
        "Tantalos",
        "Tanuga",
        "Tarchannen",
        "Terosa",
        "Thera",
        "Titan",
        "Torin",
        "Triacus",
        "Turkana",
        "Tyrus",
        "Umberlee",
        "Utopia",
        "Vadera",
        "Vagra",
        "Vandor",
        "Ventax",
        "Xenon",
        "Xerxes",
        "Yew",
        "Yojimbo",
        "Zalkon",
        "Gorgon",
        "Hydra",
        "Phoenix",
        "Gagrin",
        "Athens",
        "Knossos",
        "Macedon",
        "Thorne",
        "Sparta",
        "Dis",
        "Farinata",
        "Century",
        "Theseus",
        "Asgard"
    ]
    
    static var solarSystems: Set<SolarSystem> = Set()
    static var locations: Dictionary<String, Coordinate> = Dictionary()
    
    private static let X_SIZE: Int = 150
    private static let Y_SIZE: Int = 100
    private static let NUM_SYSTEMS: Int = 10
    private static let MAX_PLANETS: Int = 3
    
    private static func generateUniverse() {
        generateSystems(systems: NUM_SYSTEMS)
    }
    
    private static func generateSystems(systems: Int) {
        for _ in 0..<systems {
            let index = Int.random(in: 0..<names.count)
            var system = SolarSystem(name: names[index], x: Int.random(in: 0..<X_SIZE), y: Int.random(in: 0..<X_SIZE))
            names.remove(at: index)
            generatePlanets(system: &system, planets: MAX_PLANETS)
            solarSystems.insert(system)
            locations[system.name] = system.location
        }
    }
    
    private static func generatePlanets(system: inout SolarSystem, planets: Int) {
        
        for _ in 0..<planets {
            let index = Int.random(in: 0..<names.count)
            system.addPlanet(planet: Planet(name: names[index], tech: Int.random(in: 0...8)))
            names.remove(at: index)
        }
    }
    
    static func shared() -> Universe {
        return universe
    }
    
}

struct SolarSystem: Hashable, Equatable {
    
    var planets: Set<Planet> = Set()
    var name: String
    var location: Coordinate
    
    init(name: String, x: Int, y: Int) {
        self.name = name
        self.location = Coordinate(x: x, y: y)
    }
    
    mutating func addPlanet(planet: Planet) {
        planets.insert(planet)
    }
    
    static func ==(lhs: SolarSystem, rhs: SolarSystem) -> Bool {
        return lhs.location == rhs.location
    }
    
    static func getDistance(first: SolarSystem, second: SolarSystem) -> Double {
        return pow(pow(Double(first.location.x - second.location.y), 2) + pow(Double(first.location.y - second.location.y) , 2), 0.5)
    }
    
}

struct Planet: Hashable, Equatable {
    
    var name: String
    var techLevel: Int
    lazy var market: Market = self.createMarket()
    
    init(name: String, tech: Int) {
        self.name = name
        self.techLevel = tech
    }
    
    init(name: String) {
        self.init(name: name, tech: 1)
    }
    
    func createMarket() -> Market { return Market(tech: techLevel) }
    
    static func ==(lhs: Planet, rhs: Planet) -> Bool {
        return lhs.name == rhs.name
    }
    
    
}

struct Coordinate: Hashable, Equatable {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    
    static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
