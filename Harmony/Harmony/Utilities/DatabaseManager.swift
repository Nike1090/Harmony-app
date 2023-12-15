//
//  DatabaseManager.swift
//  Harmony
//
//  Created by Karicharla sricharan on 12/14/23.
//

//import Foundation
//import GRDB
// 
//
// 
//class DatabaseManager {
//    //Variable for writing into database
//    private let dbWriter: any DatabaseWriter
//    
//    //Variable for reading from the database
//    var dbReader: DatabaseReader {
//        dbWriter
//    }
//    static let shared = makeShared()
//    
//    //Creating db.sqlite file
//    private static func makeShared() -> DatabaseManager {
//        do {
//            print("Database is working fine!!")
//            let databaseURL = try FileManager.default
//                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                .appendingPathComponent("FinalDataBaseModel.sqlite")
//            print(databaseURL.path + "Hi")
//            
//            //dbQueue = try DatabaseQueue(path: databaseURL.path)
//            
//            //A database pool allows concurrent database accesses.
//            let dbPool = try DatabasePool(path: databaseURL.path)
//            
//            let databaseManager = try DatabaseManager(dbWriter: dbPool)
//            return databaseManager
//        } catch {
//            fatalError("Crashed: \(error)")
//        }
//        
//    }
//    
//    init(dbWriter: any DatabaseWriter) throws {
//        self.dbWriter = dbWriter
//        try migrator.migrate(dbWriter)
//    }
//    
//    private var migrator: DatabaseMigrator {
//        var migrator = DatabaseMigrator()
//        
//        migrator.eraseDatabaseOnSchemaChange = true
//        
//        // Registering migration for creating new tables
//        migrator.registerMigration("createTable") { db in
//            
//            // User Table
//            try db.create(table: "user") { t in
//                t.column("user_Id", .integer).primaryKey()
//                t.column("name", .text)
//                t.column("email", .text)
//                t.column("password", .text)
//            }
// 
//            // Moods Table
//            try db.create(table: "moods") { t in
//                t.column("mood_Id", .integer).primaryKey()
//                t.column("user_Id", .integer).indexed()
//                t.column("feeling_text", .text).indexed()
//                t.column("mood_type", .text)
//                t.foreignKey(["user_Id"], references: "user", onDelete: .cascade)
//            }
//            
//
//            
//        }
//        return migrator
//    }
// 
//}
// 
//extension DatabaseManager {
//    
//    //Creating a generic parameter for flexibility and reusability
//    //T - generic type
//    
//    //Function to save records (write)
//    func saveRecord<T: MutablePersistableRecord>(item: T) {
//        var item = item
//        do {
//            try dbWriter.write { db in
//                try item.save(db)
//            }
//        } catch {
//            print("Failed to save \(error)")
//        }
//    }
//    
//    //Function to fetch records (read)
//    func fetchRecords<T: FetchableRecord & TableRecord>(type: T.Type) ->[T] {
//        do {
//            let records = try dbReader.read { db in
//                return try T.fetchAll(db)
//            }
//            return records
//        } catch {
//            print("Failed to fetch \(error)")
//        }
//        return []
//    }
//    
//    //Function to delete records
//    func deleteRecord<T: FetchableRecord & TableRecord>(type: T.Type, id: Int) {
//        do {
//            try _ = dbWriter.write { db in
//                try T.deleteOne(db, key: id)
//            }
//        } catch {
//            print("Failed to delete \(error)")
//        }
//    }
//    
//    //Functtion to update records
//    func updateRecord<T: MutablePersistableRecord>(item: T) {
//        do {
//            try dbWriter.write { db in
//                try item.update(db)
//            }
//        } catch {
//            print("Failed to update \(error)")
//        }
// 
//    }
//}
