//
//  Hike.swift
//  Landmarks
//
//  Created by MacBook Pro on 19/04/24.
//

import Foundation

// Struktur dari hike
struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]

    // Sebuah formatter untuk jarak
    static var formatter = LengthFormatter()

    var distanceText: String {
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }

    // Struktur dari observasi hasil hiking
    struct Observation: Codable, Hashable {
        var distanceFromStart: Double
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}
