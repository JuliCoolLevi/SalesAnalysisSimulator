//
//  Model.swift
//  SalesAnalysisSimulator
//
//  Created by Julius Nillo on 2025-09-03.
//

import Foundation
import SQLite

struct BestSeller: Identifiable {
    let id = UUID()
    let name: String
    let sales: Double // this is in millions
}

struct PlatformGames: Identifiable {
    let id = UUID()
    let name: String
    let platformCount: Int
}

struct Genre: Identifiable {
    let id = UUID()
    let genre: String
    let gameCount: Int
}

class MyViewModel {
    private let db = DatabaseManager.shared.getDb()
    
    // tables and columns
    private let table = Table("video_game_sales")
    private let nameCol = SQLite.Expression<String>("Name")
    private let salesCol = SQLite.Expression<Double>("Global_Sales")
    private let platCol = SQLite.Expression<String>("Platform")
    private let genreCol = SQLite.Expression<String>("Genre")
    
    //methods
    func getBestSellers(limit: Int = 10) throws -> [BestSeller] {
        var rows: [BestSeller] = []
        
        let query = table.select(nameCol, salesCol)
            .order(salesCol.desc)
            .limit(limit)
        
        for row in try db.prepare(query) {
            rows.append(BestSeller(name: row[nameCol], sales: Double(row[salesCol]) ?? 0.0))
        }
        return rows
    }
    
    func getPlatformsByGameCount(limit: Int = 10) throws -> [PlatformGames] {
        var rows: [PlatformGames] = []
        let cnt = nameCol.count
        
        let query = table
            .select(platCol, cnt)
            .group(platCol)
            .order(cnt.desc)
            .limit(limit)
        
        for row in try db.prepare(query) {
            rows.append(PlatformGames(name: row[platCol], platformCount: row[cnt]))
        }
        return rows
    }
    
    func getTopGenresByCount(limit: Int = 10) throws -> [Genre] {
        var rows: [Genre] = []
        let cnt = nameCol.count
        
        let query = table
            .select(genreCol, cnt)
            .group(genreCol)
            .order(cnt.desc)
            .limit(limit)
        
        for row in try db.prepare(query) {
            rows.append(Genre(genre: row[genreCol], gameCount: row[cnt]))
        }
        return rows
    }

    
    
}

