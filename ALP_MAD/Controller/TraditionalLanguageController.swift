//
//  TraditionalLanguageController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation

class TraditionalLanguageController : ObservableObject {
    
    @Published private var traditionalLanguage: TraditionalLanguage = TraditionalLanguage(
        answer: "",
        image: "",
        description: "",
        provinceOrigin: "",
        provinceOptions: [""],
        clue: "",
        sentences: ""
    )
    
    @Published var isWrong: Bool = false
    @Published var isCorrect: Bool = false
    @Published private var isThere: Bool = false
    @Published var point: Int = 0

    func wrongAnswer() {
        self.isWrong = true
    }
    
    func changeLanguage(language: TraditionalLanguage) {
        self.traditionalLanguage = language
    }
    
    func guessWord(word : String, remainingTime: Int) {
        if (traditionalLanguage.answer == word.uppercased()) {
            print("BENERR")
            correctAnswer(remainingTime: remainingTime)
        }
        else {
            print("HAA")
            wrongAnswer()
        }
        print(word)
        print(traditionalLanguage.answer)
        if word.uppercased() == traditionalLanguage.answer {
            print("WTF")
        }
    }
    
    func correctAnswer(remainingTime: Int) {
        self.isCorrect = true
        print(ModelData.shared.currentUser.score)
        ModelData.shared.currentUser.score += (remainingTime * 10)
        self.point += (remainingTime * 10)
        print(ModelData.shared.currentUser.score)
        if traditionalLanguage.answer == ModelData.shared.bali.traditionalLanguage.answer {
            for id in ModelData.shared.bali.userList.indices {
                print(ModelData.shared.bali.userList.count)
                if ModelData.shared.bali.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.bali.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.bali.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalLanguage.answer == ModelData.shared.kalimantan.traditionalLanguage.answer {
            for id in ModelData.shared.kalimantan.userList.indices {
                if ModelData.shared.kalimantan.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.kalimantan.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.kalimantan.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalLanguage.answer == ModelData.shared.sumatera.traditionalLanguage.answer {
            for id in ModelData.shared.sumatera.userList.indices {
                if ModelData.shared.sumatera.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.sumatera.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.sumatera.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalLanguage.answer == ModelData.shared.sulawesi.traditionalLanguage.answer {
            for id in ModelData.shared.sulawesi.userList.indices {
                if ModelData.shared.sulawesi.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.sulawesi.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.sulawesi.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalLanguage.answer == ModelData.shared.java.traditionalLanguage.answer {
            for id in ModelData.shared.java.userList.indices {
                if ModelData.shared.java.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.java.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.java.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalLanguage.answer == ModelData.shared.papua.traditionalLanguage.answer {
            for id in ModelData.shared.papua.userList.indices {
                if ModelData.shared.papua.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.papua.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.papua.userList[id].score += (remainingTime * 10)
                }
            }
        }

    }
    
    func getTraditionalLanguage() -> TraditionalLanguage {
        return self.traditionalLanguage
    }
    
}
