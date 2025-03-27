//
//  generateTableData.swift
//  Optimizasyon
//
//  Created by mehmet Çelik on 27.03.2025.
//

import Foundation


func generateTableData(yValues: [String]) -> [[TableCell]] {
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
    
    // 3. Row 1
    var row1: [TableCell] = [
        TableCell(content: "-2"),
        TableCell(content: "x₄"),
        TableCell(content: "20")
    ]
    for _ in yValues {
        row1.append(TableCell(content: "\(Int.random(in: 0...2))"))
    }
    data.append(row1)
    
    // 4. Row 2
    var row2: [TableCell] = [
        TableCell(content: "1"),
        TableCell(content: "x₂"),
        TableCell(content: "12")
    ]
    for _ in yValues {
        row2.append(TableCell(content: "\(Int.random(in: 0...2))"))
    }
    data.append(row2)

    // 5. Bottom Z-row
    var zRow: [TableCell] = [
        TableCell(content: "-28", color: .gray),
        TableCell(content: "", color: .clear),
        TableCell(content: "", color: .clear)
    ]
    for _ in yValues {
        zRow.append(TableCell(content: "\(Int.random(in: -6...0))"))
    }
    data.append(zRow)

    return data
}
