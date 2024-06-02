//
//  HomeController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation
import SwiftUI

class HomeController : ObservableObject {
    
    //    @Published private var home : Home
    
        
    @Published var progressToRank: [Island] = []
    @Published var unfilledIslands: [Island] = []
    @Published var rankedIslands: [Island] = []
    @Published var combinedArray: [Island] = []
    
    init() {
        print("HAHAHA \(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.java))")
    }
    
    func sortBaliRank() {
        ModelData.shared.bali.userList.sort { $0.score > $1.score }
    }
    
    func sortJavaRank() {
        ModelData.shared.java.userList.sort { $0.score > $1.score }
    }
    
    func sortSumateraRank() {
        ModelData.shared.sumatera.userList.sort { $0.score > $1.score }
    }
    
    func sortKalimantanRank() {
        ModelData.shared.kalimantan.userList.sort { $0.score > $1.score }
    }
    
    func sortPapuaRank() {
        ModelData.shared.papua.userList.sort { $0.score > $1.score }
    }
    
    func sortSulawesiRank() {
        ModelData.shared.sulawesi.userList.sort { $0.score > $1.score }
    }
    
    func rearrangeIsland() {
        sortBaliRank()
        sortJavaRank()
        sortSumateraRank()
        sortPapuaRank()
        sortKalimantanRank()
        sortSulawesiRank()
        
        print(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.java))
        
        let islands: [Island] = [
            ModelData.shared.bali,
            ModelData.shared.sumatera,
            ModelData.shared.kalimantan,
            ModelData.shared.java,
            ModelData.shared.papua,
            ModelData.shared.sulawesi
        ]
////
////        
        for id in islands.indices {
            if id >= 0 && id < islands.count {
                if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: islands[id]).isEmpty {
                    unfilledIslands.append(islands[id])
                }
            }
            
        }
        print(unfilledIslands.count)
        
        for id in islands.indices {
            do {
                let detail = try ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: islands[id])
                
                if !detail.isEmpty, detail[0] == 0 {
                    rankedIslands.append(islands[id])
//                    print("Pulau \(islands[id]) + Poin \(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: islands[id]))")
                }
            } catch {
                print("Error!")
            }
            
        }
        
        for id in islands.indices {
            do {
                let detail = try ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: islands[id])
                
                if !detail.isEmpty, detail[0] == 1 {
                    rankedIslands.append(islands[id])
//                    print("Pulau \(islands[id]) + Poin \(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: islands[id]))")
                }
            } catch {
                print("Error!")
            }
            
        }
        
        for id in islands.indices {
            do {
                let detail = try ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: islands[id])
                
                if !detail.isEmpty, detail[0] == 2 {
                    rankedIslands.append(islands[id])
//                    print("Pulau \(islands[id]) + Poin \(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: islands[id]))")
                }
            } catch {
                print("Error!")
            }
            
        }
        
        for id in islands.indices {
            do {
                let detail = try ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: islands[id])
                
                if !detail.isEmpty, detail[0] == 3 {
                    progressToRank.append(islands[id])
//                    print("Pulau \(islands[id]) + Poin \(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: islands[id]))")
                }
            } catch {
                print("Error!")
            }
            
        }
    }
    
    func getCombinedAllArray() -> [Island] {
        combinedArray = rankedIslands + progressToRank + unfilledIslands
        return self.combinedArray
    }
    
    func registerAccount(textInput: String, selectedImage: Data?, showAlert: Binding<Bool>, alertMessage: Binding<String>) {
        let trimmedTextInput = textInput.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedTextInput.isEmpty && selectedImage == nil {
            alertMessage.wrappedValue = "Anda lupa memasukkan nama dan foto profil."
            showAlert.wrappedValue = true
            return
        }
        else if trimmedTextInput.isEmpty {
            alertMessage.wrappedValue = "Anda lupa memasukkan nama."
            showAlert.wrappedValue = true
            return
        }
        else if selectedImage == nil {
            alertMessage.wrappedValue = "Anda lupa memasukkan foto profil."
            showAlert.wrappedValue = true
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        do {
            try selectedImage?.write(to: imagePath)
            
            let user = User(name: textInput, image: imageName, score: 0)
            ModelData.shared.currentUser = user
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
