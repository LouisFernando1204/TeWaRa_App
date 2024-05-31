//
//  CustomGradient.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import Foundation
import SwiftUI

class CustomGradient {
    
    static let redOrangeGradient: LinearGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(red: 220/255, green: 38/255, blue: 38/255),
                Color(red: 251/255, green: 146/255, blue: 60/255)
            ]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let redDarkRedGradient: LinearGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(red: 220/255, green: 38/255, blue: 38/255),
                Color(red: 118/255, green: 20/255, blue: 20/255)
            ]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )
}
