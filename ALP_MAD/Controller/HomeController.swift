//
//  HomeController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation
import UIKit
import SwiftUI

class HomeController : ObservableObject {
    
    //    @Published private var home : Home
    
    init() {
        
    }
    
    func navigateToLeaderboardView() {
        
    }
    
    func navigateToIslandView() {
        
    }
    
    //    func getHome() -> Home {
    //        return self.home
    //    }
    
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
