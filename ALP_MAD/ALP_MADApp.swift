//
//  ALP_MADApp.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

@main
struct ALP_MADApp: App {
    @State private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            IslandView()
                .environment(modelData)
        }
    }
}
