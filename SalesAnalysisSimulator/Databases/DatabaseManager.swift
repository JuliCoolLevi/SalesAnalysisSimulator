//
//  DatabaseManager.swift
//  SalesAnalysisSimulator
//
//  Created by Julius Nillo on 2025-09-03.
//

import Foundation
import SQLite

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let db : Connection
    
    init() {
        guard let url = Bundle.main.url(forResource: "sales", withExtension: "db") else {
            fatalError("sales.db not found in bundle. Check Target Membership.")
        }
        do {
            db = try Connection("./\(url.path)")
        } catch {
            fatalError("Failed to open DB: \(error)")
        }
        
    }
    
    func getDb() -> Connection {
        return db
    }
    
}
