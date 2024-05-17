//
//  HomeView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ForEach(ModelData.shared.sulawesi.userList, id: \.self){ user in
            Text("\(user.score)")
        }
    }
}

#Preview {
    HomeView()
}
