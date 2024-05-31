//
//  modelData.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 15/05/24.
//

import Foundation

@Observable
class ModelData {
    var sumatera: Island = load("SumateraData.json")
    var bali: Island = load("BaliData.json")
    var java: Island = load("JavaData.json")
    var kalimantan: Island = load("KalimantanData.json")
    var papua: Island = load("PapuaData.json")
    var sulawesi: Island = load("SulawesiData.json")
    var currentUser: User
    var currentIsland : Island
    static let shared = ModelData()
    
    private init() {
        self.currentUser = User(name: "Radhita Lope", image: "radhita", score: 0)
        self.currentIsland = Island(
            islandName: "",
            islandImage: "",
            traditionalDance: TraditionalDance(
                answer: "",
                image: "",
                description: "",
                provinceOrigin: "",
                provinceOptions: [""],
                throwableAnswer: [
                    Alphabet(
                        alphabet: "",
                        isClicked: false
                    )
                ],
                availableWords: [
                    Alphabet(
                        alphabet: "",
                        isClicked: false
                    )
                ]
            ),
            traditionalLanguage: TraditionalLanguage(
                answer: "",
                image: "",
                description: "",
                provinceOrigin: "",
                provinceOptions: [""],
                clue: "",
                sentences: ""
            ),
            userList: [
                User(
                    name: "",
                    image: "",
                    score: 0
                )
            ]
        )
    }
}

// Memuat data dari JSON
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) 
    else {
       
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
