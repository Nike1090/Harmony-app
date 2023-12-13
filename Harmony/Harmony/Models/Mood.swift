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
    var moodId: Int
    var userId: Int
    var feelingText: String
    var moodType: MoodType
    var date: Date
    
    // Additional properties related to mood tracking
    
    // Example initializer for Mood
    init(moodId: Int, userId: Int, feelingText: String, moodType: MoodType, date: Date) {
           self.moodId = moodId
           self.userId = userId
           self.feelingText = feelingText
           self.moodType = moodType
           self.date = date
       }
    
    
}
