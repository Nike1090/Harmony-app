//
//  Mood.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/1/23.
//

import Foundation
import GRDB

struct Mood: Codable, FetchableRecord, MutablePersistableRecord {
    enum MoodType: String, Codable {
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
    
    // Conformance to Encodable and Decodable
    private enum CodingKeys: String, CodingKey {
        case moodId, userId, feelingText, moodType, date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.moodId = try container.decode(Int.self, forKey: .moodId)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.feelingText = try container.decode(String.self, forKey: .feelingText)
        self.date = try container.decode(Date.self, forKey: .date)
        
        let moodTypeString = try container.decode(String.self, forKey: .moodType)
        self.moodType = MoodType(rawValue: moodTypeString) ?? .excellent
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(moodId, forKey: .moodId)
        try container.encode(userId, forKey: .userId)
        try container.encode(feelingText, forKey: .feelingText)
        try container.encode(date, forKey: .date)
        try container.encode(moodType.rawValue, forKey: .moodType)
    }
}
