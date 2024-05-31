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
    
    var currentIslandObject: Island
    var currentIsland: String
    var currentUser: User
    var currentGame: String
    
    static let shared = ModelData()
    
    private init(){
        self.currentIslandObject = Island(
            islandName: "Sulawesi",
            islandImage: "sulawesi",
            traditionalDance: TraditionalDance(
                answer: "PAJOGE",
                image: "TariPajoge-SulawesiSelatan",
                description: "Tari Pajoge adalah tari tradisional yang berasal dari Bone, Sulawesi Selatan. Tarian ini konon awalnya merupakan hiburan bagi kalangan istana atau juga kediaman para ningrat. Para penarinya adalah gadis yang berlatar belakang kalangan rakyat biasa.",
                provinceOrigin: "Sulawesi Selatan",
                provinceOptions: [
                    "Sulawesi Utara", "Sulawesi Selatan",
                    "Sulawesi Barat", "Sulawesi Timur"
                ],
                answerOptions: [
                    "A", "P", "Z", "S",
                    "I", "J", "E", "O",
                    "G", "I", "N", "Y"
                ]
            ),
            traditionalLanguage: TraditionalLanguage(
                answer: "BUGIS",
                image: "rumahBersih",
                description: "'Bolana macakka' merupakan bahasa Bugis dari kalimat 'Rumah ini bersih'. Bahasa Bugis merupakan bahasa yang sudah digunakan sejak zaman Kerajaan Bugis di abad ke-14. Bahasa ini juga digunakan sebagai bahasa perdagangan yang meluas hingga ke luar Sulawesi Selatan. ",
                sentences: "Bolana macakka",
                provinceOrigin: "Sulawesi Selatan",
                provinceOptions: [
                    "Sulawesi Utara", "Sulawesi Selatan",
                    "Sulawesi Barat", "Sulawesi Timur"
                ],
                clue: "Terdapat 27 dialek dari bahasa ini, salah satunya yaitu dialek Bone."
            ),
            userList: [
                User(
                    name: "Hiroshi",
                    image: "person10",
                    score: 270
                ),
                User(
                    name: "Nicho",
                    image: "person11",
                    score: 210
                ),
                User(
                    name: "Patrick",
                    image: "person12",
                    score: 200
                )
            ]
        )
        self.currentIsland = "Sulawesi"
        self.currentUser = User(
            name: "Hiroshi",
            image: "person10",
            score: 270
        )
        self.currentGame = "TraditionalDance"
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
