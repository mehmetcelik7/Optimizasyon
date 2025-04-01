//
//  generateTableData.swift
//  Optimizasyon
//
//  Created by mehmet Çelik on 27.03.2025.
//

import Foundation
import SwiftUI

struct TableCell: Identifiable {
    var id = UUID()
    var content: String
    var color: Color = .white
}



func generateTableData(yValues: [String], constraintCount: Int) -> [[TableCell]] {
    var data: [[TableCell]] = []
    
    // 1. Header Row
    var headerRow: [TableCell] = [
        TableCell(content: "TABLO I", color: .blue),
        TableCell(content: "", color: .clear),
        TableCell(content: "", color: .clear)
    ]
    for value in yValues {
        headerRow.append(TableCell(content: value))
    }
    data.append(headerRow)
    
    // 2. Column Titles
    var titleRow: [TableCell] = [
        TableCell(content: "C_B", color: .gray),
        TableCell(content: "T_v", color: .gray),
        TableCell(content: "X_B", color: .gray)
    ]
    for (index, _) in yValues.enumerated() {
        titleRow.append(TableCell(content: "y₍\(index + 1)₎", color: .gray))
    }
    data.append(titleRow)
    
    // 3. Constraint Rows
    for i in 0..<constraintCount {
        var row: [TableCell] = [
            TableCell(content: "0"), // Example content for C_B
            TableCell(content: "x\(i + 1)"), // Example content for T_v
            TableCell(content: "\(Int.random(in: 10...30))") // Example content for X_B
        ]
        for _ in yValues {
            row.append(TableCell(content: "\(Int.random(in: 0...2))"))
        }
        data.append(row)
    }

    // 5. Bottom Z-row
    var zRow: [TableCell] = [
        TableCell(content: "0", color: .gray),
        TableCell(content: "", color: .clear),
        TableCell(content: "", color: .clear)
    ]
    for _ in yValues {
        zRow.append(Int(0).description.isEmpty ? TableCell(content: "0", color: .init(red: 0.9, green: 0.9, blue: 0.9)) : TableCell(content: "0"))
    }
    data.append(zRow)

    return data
}
