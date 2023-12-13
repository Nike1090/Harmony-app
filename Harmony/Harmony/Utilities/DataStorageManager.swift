//
//  DataStorageManager.swift
//  Harmony
//
//  Created by Nikhil kumar  on 12/1/23.
//

import Foundation
import SQLite

class DataStorageManager {
    static let shared = DataStorageManager()
    var db: Connection?
    

    
    private init() {
        do {
            // Get the path of the SQLite database file in the app's bundle
            if let dbPath = Bundle.main.path(forResource: "HarmonyDataModel", ofType: "sqlite") {
                // Create a database connection
                db = try Connection(dbPath)
                
                // Create tables
                try createTables()
                // Insert data
                insertInitialData()
                
            } else {
                print("HarmonyDataModel.sqlite file not found in the app's bundle.")
            }
        } catch {
            print("Error creating database connection: \(error)")
        }
    }
    
    
    private func createTables() throws {
        do {
            // Create User table
            let user = Table("user")
            let userId = Expression<Int>("user_Id")
            let name = Expression<String>("name")
            let email = Expression<String>("email")
            let password = Expression<String>("password")
            
            try db?.run(user.create(ifNotExists: true) { table in
                table.column(userId, primaryKey: true)
                table.column(name)
                table.column(email)
                table.column(password)
            })
            
            // Create Mood table
            let mood = Table("mood")
            let moodId = Expression<Int>("mood_Id")
            let userIdRef = Expression<Int>("user_Id")
            let feelingText = Expression<String>("feeling_text")
            let moodType = Expression<String>("mood_type")
            let date = Expression<Date>("date")
                    
            try db?.run(mood.create(ifNotExists: true) { table in
                table.column(moodId, primaryKey: true)
                table.column(userIdRef)
                table.column(feelingText)
                table.column(moodType)
                table.column(date)
                table.foreignKey(userIdRef, references: user, userId)
                    })
            
            
        } catch {
            // Handle the error here
            print("Error creating tables: \(error)")
            throw error
        }
    }
    
    
    private func insertInitialData() {
        do {
            // Insert data into User table
            let user = Table("user")
            let guestUser = user.insert(or: .ignore, [
                Expression<Int>("user_Id") <- 100,
                Expression<String>("name") <- "admin",
                Expression<String>("email") <- "admin@gmail.com",
                Expression<String>("password") <- "admin"
            ])
            
            try db?.run(guestUser)
            
            
            
        } catch {
            // Handle the error here
            print("Error inserting initial data: \(error)")
        }
    }
    
    
    func insertUser(userId: Int, name: String, email: String, password: String) throws {
        let user = Table("user")
        let userIdExp = Expression<Int>("user_Id")
        let nameExp = Expression<String>("name")
        let emailExp = Expression<String>("email")
        let passwordExp = Expression<String>("password")

        let insertUser = user.insert(or: .ignore,
            userIdExp <- userId,
            nameExp <- name,
            emailExp <- email,
            passwordExp <- password
        )

        try db?.run(insertUser)
    }
    
    
    
    
    func saveMoodForCurrentUser(mood: Mood) {

        do {
            let moodTable = Table("mood")
            let moodIdExp = Expression<Int>("mood_Id")
            let userIdExp = Expression<Int>("user_Id")
            let feelingTextExp = Expression<String>("feeling_text")
            let moodTypeExp = Expression<String>("mood_type")
            let dateExp = Expression<Date>("date")

            let insertMood = moodTable.insert(
                moodIdExp <- mood.moodId,
                userIdExp <- mood.userId,
                feelingTextExp <- mood.feelingText,
                moodTypeExp <- mood.moodType.rawValue,
                dateExp <- mood.date
            )

            try db?.run(insertMood)
        } catch {
            // Handle the error here
            print("Error inserting mood data: \(error)")
        }
    }
    
    

    
    func updateUserMoods(for user: User) {}
    
    
    func retrieveUsers() -> [User] {
        do {
            let user = Table("user")
            let userId = Expression<Int>("user_Id")
            let name = Expression<String>("name")
            let email = Expression<String>("email")
            let password = Expression<String>("password")
            
            let query = user.select(userId, name, email, password)
            
            guard let userRows = try db?.prepare(query) else {
                        // Handle the case when userRows is nil
                        print("No user rows found.")
                        return []
                    }
            
            var result: [User] = []
            
            for row in userRows {
                let user = User(
                    userId: row[userId],
                    name: row[name],
                    email: row[email],
                    password: row[password]
                )
                result.append(user)
            }
            
            return result
        } catch {
            // Handle the error here
            print("Error retrieving users: \(error)")
            return []
        }
    }
 
    func retrieveMoods(for userId: Int) -> [Mood] {
        do {
            let mood = Table("mood")
            let moodId = Expression<Int>("mood_Id")
            let userIdRef = Expression<Int>("user_Id")
            let feelingText = Expression<String>("feelingText")
            let moodType = Expression<String?>("moodType")
            let date = Expression<Date>("date")

            let query = mood.select(moodId, userIdRef, feelingText, moodType, date)
                            .filter(userIdRef == userId)

            guard let moodRows = try db?.prepare(query) else {
                // Handle the case when moodRows is nil
                print("No mood rows found.")
                return []
            }

            var result: [Mood] = []

            for row in moodRows {
                if let moodTypeString = row[moodType],
                   let moodTypeEnum = Mood.MoodType(rawValue: moodTypeString) {
                    let mood = Mood(
                        moodId: row[moodId],
                        userId: row[userIdRef],
                        feelingText: row[feelingText],
                        moodType: moodTypeEnum,
                        date: row[date]
                    )
                    result.append(mood)
                }
            }

            return result
        } catch {
            // Handle the error here
            print("Error retrieving moods: \(error)")
            return []
        }
    }

    
    
    
    
}
    
