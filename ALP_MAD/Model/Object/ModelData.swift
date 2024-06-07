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
    var currentIsland : String
    static let shared = ModelData()
    
    var currentIslandObject: Island
    var currentGame: String
    
    private init() {
        self.currentGame = ""
        self.currentIsland = ""
        self.currentUser = User(name: "Radhita Lope", image: "person1", score: 0)
        self.currentIslandObject = Island(islandName: "", islandImage: "", traditionalDance: TraditionalDance(answer: "", description: "", provinceOrigin: "", provinceOptions: [], answerOptions: []), traditionalLanguage: TraditionalLanguage(answer: "", image: "", description: "", sentences: "", provinceOrigin: "", provinceOptions: [], clue: ""), userList: [])
    }
    
//    func getCurrentUserDetailInBali(name: String) -> [Int] {
//        return ModelData.shared.bali.userList.enumerated().compactMap { index, user in
//            user.name == name ? index : nil
//        }
//    }
    
    func getCurrentDetailUserByIsland(name: String, island: Island) -> [Int] {
        return island.userList.enumerated().compactMap { index, user in
            user.name == name ? index : nil
        }
    }
    
    func getCurrentUserPointByIsland(name: String, island: Island) -> [Int] {
        return island.userList.enumerated().compactMap { index, user in
            user.name == name ? user.score : nil
        }
    }
    
//    func getCurrentUserDetailInJava(name: String) -> [Int] {
//        return ModelData.shared.java.userList.enumerated().compactMap { index, user in
//            user.name == name ? index : nil
//        }
//    }
    
//    func getCurrentUserDetailInSumatera(name: String) -> [Int] {
//        return ModelData.shared.sumatera.userList.enumerated().compactMap { index, user in
//            user.name == name ? index : nil
//        }
//    }
//
//    func getCurrentUserDetailInKalimantan(name: String) -> [Int] {
//        return ModelData.shared.kalimantan.userList.enumerated().compactMap { index, user in
//            user.name == name ? index : nil
//        }
//    }
//
//    func getCurrentUserDetailInPapua(name: String) -> [Int] {
//        return ModelData.shared.papua.userList.enumerated().compactMap { index, user in
//            user.name == name ? index : nil
//        }
//    }
//
//    func getCurrentUserDetailInSulawesi(name: String) -> [Int] {
//        return ModelData.shared.sulawesi.userList.enumerated().compactMap { index, user in
//            user.name == name ? index : nil
//        }
//    }
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
