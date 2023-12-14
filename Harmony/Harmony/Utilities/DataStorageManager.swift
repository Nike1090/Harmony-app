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
            
            // Create User table
            let task = Table("task")
            let taskdi = Expression<Int>("taskid")
            
            
            try db?.run(task.create(ifNotExists: true) { table in
                table.column(taskdi, primaryKey: true)
                
            })
            
            
            // Create Mood table
            let moods = Table("moods")
            let moodId = Expression<Int>("mood_Id")
            let userIdRef = Expression<Int>("user_Id")
            let feelingText = Expression<String>("feeling_text") // Corrected column name
            let moodType = Expression<String>("mood_type")
            let date = Expression<Date>("date")

            try db?.run(moods.create(ifNotExists: true) { table in
                table.column(moodId, primaryKey: true)
                table.column(userIdRef)
                table.column(feelingText) // Corrected column name
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

    
    func debugMoodsTable() {
        do {
            let moodsTable = Table("moods")
            
            // Check if the mood table exists
            let tableExists = try db?.scalar(moodsTable.exists)
            if let exists = tableExists, exists {
                print("The 'moods' table exists.")
                
                // Retrieve rows from the mood table
                let query = moodsTable.select(*)
                guard let moodRows = try db?.prepare(query) else {
                    print("No moods rows found.")
                    return
                }
                
                print("Rows in the 'moods' table:")
                for row in moodRows {
                    print("Mood ID: \(row[Expression<Int>("mood_Id")]), User ID: \(row[Expression<Int>("user_Id")]), Feeling Text: \(row[Expression<String>("feeling_text")]), Mood Type: \(row[Expression<String>("mood_type")]), Date: \(row[Expression<Date>("date")])")
                }
            } else {
                print("The 'moods' table does not exist.")
            }
        } catch {
            // Handle the error here
            print("Error debugging 'mood' table: \(error)")
        }
    }
    
//    func debugMoodsTableExistence() {
//        do {
//            // Check if the "moods" table exists in the database
//            let query = "SELECT name FROM sqlite_master WHERE type='table' AND name='moods';"
//            let result = try db?.scalar(query)
//
//            if let tableName = result as? String, tableName == "moods" {
//                print("The 'moods' table exists.")
//            } else {
//                print("The 'mooods' table does not exist.")
//            }
//        } catch {
//            print("Error checking 'moods' table existence: \(error)")
//        }
//    }
    
    func debugMoodsTableExistence() {
        do {
            // Check if the "moods" table exists in the database
            let query = "SELECT name FROM sqlite_master WHERE type='table' AND name='moods';"
            let result = try db?.scalar(query)

            if let tableName = result as? String, tableName == "moods" {
                print("The 'moods' table exists.")

                // Fetch and print rows of the 'moods' table
                let moodTable = Table("moods")
                let moodId = Expression<Int>("mood_Id")
                let userId = Expression<Int>("user_Id")
                let feelingText = Expression<String>("feeling_text")
                let moodType = Expression<String>("mood_type")
                let date = Expression<Date>("date")

                do {
                    let query = moodTable.select(moodId, userId, feelingText, moodType, date)
                    if let rows = try db?.prepare(query) {
                        for row in rows {
                            print("Mood ID: \(row[moodId]), User ID: \(row[userId]), Feeling Text: \(row[feelingText]), Mood Type: \(row[moodType]), Date: \(row[date])")
                        }
                    } else {
                        print("No rows found in the 'moods' table.")
                    }
                } catch {
                    print("Error fetching rows from 'moods' table: \(error)")
                }
            } else {
                print("The 'moods' table does not exist.")
            }
        } catch {
            print("Error checking 'moods' table existence: \(error)")
        }
    }




    
//    func debugUserTable() {
//            do {
//                let userTable = Table("user")
//
//                // Check if the user table exists
//                let tableExists = try db?.scalar(userTable.exists)
//                if let exists = tableExists, exists {
//                    print("The 'user' table exists.")
//
//                    // Retrieve rows from the user table
//                    let query = userTable.select(*)
//                    guard let userRows = try db?.prepare(query) else {
//                        print("No user rows found.")
//                        return
//                    }
//
//                    print("Rows in the 'user' table:")
//                    for row in userRows {
//                        print("User ID: \(row[Expression<Int>("user_Id")]), Name: \(row[Expression<String>("name")]), Email: \(row[Expression<String>("email")]), Password: \(row[Expression<String>("password")])")
//                    }
//                } else {
//                    print("The 'user' table does not exist.")
//                }
//            } catch {
//                // Handle the error here
//                print("Error debugging 'user' table: \(error)")
//            }
//        }


    
//    func dropTable() {
//            do {
//                let Table = Table("")
//                try db?.run(Table.drop(ifExists: true))
//                print("table dropped successfully.")
//            } catch {
//                // Handle the error here
//                print("Error dropping table: \(error)")
//            }
//        }

    
}
    
