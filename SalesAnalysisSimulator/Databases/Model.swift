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

class MyViewModel {
    private let db = DatabaseManager.shared.getDb()
    
    // tables and columns
    private let table = Table("video_game_sales")
    private let nameCol = SQLite.Expression<String>("Name")
    private let salesCol = SQLite.Expression<Double>("Global_Sales")
    
    
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
    
}

