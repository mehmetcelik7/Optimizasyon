//
//  SimplexTableView.swift
//  Optimizasyon
//
//  Created by mehmet Çelik on 26.03.2025.
//
import SwiftUI

struct SimplexTableView: View {
    @State var table: SimplexTable
    
    var body: some View {
        ScrollView([.vertical, .horizontal]) {
            Grid {
                // İlk satırda sütun başlıkları
                GridRow {
                    // Boşluk veya sol üst köşe (Row header label)
                    Text(" ")
                        .bold()
                        .frame(minWidth: 60)
                    
                    // Sütun başlıklarını GridRow içinde oluştur
                    ForEach(table.columnHeaders, id: \.self) { header in
                        Text(header)
                            .bold()
                            .frame(minWidth: 60)
                            .border(.black)
                    }
                }
                
                // Her bir satırı oluştur
                ForEach(0..<table.rows.count, id: \.self) { rowIndex in
                    GridRow {
                        // Satır başlığı
                        Text(table.rows[rowIndex].label)
                            .bold()
                            .frame(minWidth: 60)
                            .border(.black)
                        
                        // Satırdaki hücreler
                        ForEach(0..<table.rows[rowIndex].cells.count, id: \.self) { colIndex in
                            let cell = table.rows[rowIndex].cells[colIndex]
                            Text("\(cell.value, specifier: "%.2f")")
                                .frame(minWidth: 60)
                                .border(.gray)
                                .background(cell.isPivot ? Color.yellow.opacity(0.3) : Color.clear)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SimplexTableView(
        table: SimplexTable(
            columnHeaders: ["x1", "x2", "Z"],
            rows: [
                RowData(
                    label: "xB",
                    cells: [
                        Cell(value: 1.0),
                        Cell(value: 2.5),
                        Cell(value: 3.0)
                    ]
                ),
                RowData(
                    label: "x1",
                    cells: [
                        Cell(value: 4.0),
                        Cell(value: 5.0),
                        Cell(value: 6.0)
                    ]
                ),
                RowData(
                    label: "x2",
                    cells: [
                        Cell(value: 7.0),
                        Cell(value: 8.0),
                        Cell(value: 9.0)
                    ]
                )
            ]
        )
    )
}
