//
//  SimplexData.swift
//  Optimizasyon
//
//  Created by mehmet Çelik on 26.03.2025.
//

import Foundation

/// Bir hücredeki sayısal değeri ve bazı ek bilgileri tutan model
struct Cell {
    var value: Double
    // Örneğin pivot, temel değişken, vb. gibi durumlar
    var isPivot: Bool = false
    var isBasicVariable: Bool = false
}

/// Bir satırı temsil eden model
struct RowData {
    var label: String       // satır başlığı (örn. xB, x1, vb.)
    var cells: [Cell]       // satırdaki hücrelerin sayısal değerleri
}

/// Tüm tabloyu temsil eden model
struct SimplexTable {
    var columnHeaders: [String]  // sütun başlıkları
    var rows: [RowData]          // tablo satırları
    
    // Örnek: Bir satır ve sütun indeksine göre değer döndürme
    func valueAt(row: Int, column: Int) -> Double {
        return rows[row].cells[column].value
    }
    
    // Örnek: Belirli bir hücreye yeni değer atama
    mutating func setValue(_ newValue: Double, row: Int, column: Int) {
        rows[row].cells[column].value = newValue
    }
    
    // Pivot gibi ek fonksiyonlar
    mutating func performPivot(pivotRow: Int, pivotCol: Int) {
        // pivot algoritması mantığına göre
        // pivot hücresini 1'e, diğerlerini 0'a çevir vs.
    }
}
