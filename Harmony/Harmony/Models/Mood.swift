//
//  Mood.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/1/23.
//

import Foundation

struct Mood {
    enum MoodType: String {
        case excellent = "Excellent"
        case good = "Good"
        case okay = "Okay"
        case bad = "Bad"
        case terrible = "Terrible"
    }
    var feelingText: String
    var moodType: MoodType
    var date: Date
    
    // Additional properties related to mood tracking
    
    // Example initializer for Mood
    init(moodType: MoodType,feelingText: String, date: Date) {
        self.feelingText = feelingText
        self.moodType = moodType
        self.date = date
    }
    
    // Example function to convert Mood to a dictionary for storage or transmission
    func toDictionary() -> [String: Any] {
        return [
            "feelingText": String.self,
            "moodType": moodType.rawValue,
            "date": date
        ]
    }
    
   
}
