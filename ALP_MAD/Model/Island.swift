//
//  Island.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation

struct Island : Codable {
    var islandName : String
    var islandImage : String
    var traditionalDance : TraditionalDance
    var traditionalLanguage : TraditionalLanguage
    var userList : [User]
}
