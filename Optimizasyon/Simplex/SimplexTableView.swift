import SwiftUI

/*
 Bu dosya, Simplex algoritması için tablo verilerinin hesaplanması ve görselleştirilmesini sağlayan SwiftUI arayüzünü içerir.
 Simplex algoritması, lineer programlama problemlerinin çözümünde kullanılan bir yöntemdir.
*/

// MARK: - SimplexTableau Struct
// Bu yapı, Simplex algoritmasında kullanılan tablo verilerini ve hesaplamaları tutar.
struct SimplexTableau {
    var m: Int                  // Kısıt sayısı (constraint count)
    var n: Int                  // Değişken sayısı (variable count)
    var A: [[Double]]           // Kısıt matrisi (m x n): Her satır bir kısıtı temsil eder.
    var b: [Double]             // Sağ taraf vektörü (m): Her kısıt için RHS değeri.
    var C: [Double]             // Amaç fonksiyonu katsayıları (n): Karar değişkenlerinin katsayıları.
    var basicVars: [Int]        // Temel değişken indeksleri (m): Şu anki temel değişkenler.
    var nonBasicVars: [Int]     // Temel olmayan değişken indeksleri (n): Şu anki temel olmayan değişkenler.
    var C_B: [Double]           // Temel değişken katsayıları (m): Amaç fonksiyonunda temel değişkenlerin katsayıları.
    var tableau: [[Double]]     // Tam Simplex tablosu (m + 1 x n + m + 1): Hesaplamaların yapıldığı tablo.

    // Yeni bir kısıt ekleme fonksiyonu.
    // Parametre olarak verilen katsayılar ve sağ taraf değeri ile tabloya yeni bir kısıt ekler.
    mutating func addConstraint(coefficients: [Double], rhs: Double) {
        m += 1
        A.append(coefficients)
        b.append(rhs)
        updateTableau()
    }

    // Yeni bir değişken ekleme fonksiyonu.
    // Amaç fonksiyonuna yeni bir değişken ekler ve her kısıt satırına ilgili sütun değerini ekler.
    mutating func addVariable(coefficient: Double, column: [Double]) {
        n += 1
        C.append(coefficient)
        for i in 0..<m {
            A[i].append(column[i])
        }
        updateTableau()
    }

    // Tabloyu güncelleme fonksiyonu.
    // Mevcut kısıt ve değişken bilgilerini kullanarak Simplex tablosunu yeniden oluşturur.
    // Not: Bu fonksiyonda pivot işlemleri henüz implemente edilmemiştir.
    mutating func updateTableau() {
        // Basit bir tablo güncellemesi: Şu an sadece mevcut verilerle tabloyu dolduruyor
        // Gerçek Simplex algoritması için pivot işlemi burada implemente edilmeli
        tableau = []
        for i in 0..<m {
            let row = [C_B[i], Double(basicVars[i])] + A[i] + [b[i]]
            tableau.append(row)
        }
        let zRow = [0.0, 0.0] + C.map { -$0 } + [0.0]
        tableau.append(zRow)
    }
}

// MARK: - TableauGridView
// Grid formatında tablo verilerini gösteren SwiftUI view.
struct TableauGridView: View {
    let tableau: [[Double]]       // Tablo verileri
    let columnHeaders: [String]   // Sütun başlıkları
    let rowHeaders: [String]      // Satır başlıkları
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Grid {
                // Başlık satırı: Sol üstte "Tablo I" metni ve sütun başlıkları.
                GridRow {
                    Text("Tablo I")
                        .frame(width: 60) // Sol üst köşeyi boş bırak
                    ForEach(columnHeaders, id: \.self) { header in
                        Text(header)
                            .font(.headline)
                            .frame(width: 60)
                            .background(Color.gray.opacity(0.2))
                    }
                }
                
                // Tablonun her satırı için veri satırları.
                ForEach(0..<tableau.count, id: \.self) { row in
                    GridRow {
                        // Satır başlığı: Her satırın başında yer alır.
                        Text(rowHeaders[row])
                            .font(.headline)
                            .frame(width: 60)
                            .background(Color.gray.opacity(0.2))
                        ForEach(0..<tableau[row].count, id: \.self) { col in
                            // Her hücredeki değerin formatlanması ve gösterimi.
                            Text(String(format: "%.2f", tableau[row][col]))
                                .frame(width: 60)
                                .padding(4)
                                .background(Color.white)
                                .border(Color.black, width: 1)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - SimplexTableView
// SimplexTableau'dan gelen verileri, uygun başlıklarla görselleştiren SwiftUI view.
struct SimplexTableView: View {
    let tableau: [[Double]]  // Simplex tablosu
    let n: Int               // Orijinal değişken sayısı
    let m: Int               // Kısıt sayısı
    
    var columnHeaders: [String] {
        // Sütun başlıklarını oluşturma: İlk iki sütun sabit, ardından değişkenler için "x0", "x1", ... ve son sütun "RHS".
        ["C_B", "T_v"] + (0..<n).map { "x\($0)" } + ["RHS"]
    }
    
    var rowHeaders: [String] {
        // Satır başlıklarını oluşturma: Her kısıt için "Kısıt 1", "Kısıt 2", ... ve son satır "Amaç".
        (0..<m).map { "Kısıt \($0 + 1)" } + ["Amaç"]
    }
    
    var body: some View {
        TableauGridView(
            tableau: tableau,
            columnHeaders: columnHeaders,
            rowHeaders: rowHeaders
        )
    }
}

// MARK: - ContentView2
// Ana view: Kullanıcı arayüzünde Simplex tablosunu gösterir ve tabloyu güncellemek için bir buton içerir.
struct ContentView2: View {
    @State private var simplex = SimplexTableau(
        m: 2,
        n: 2,
        // Kısıt matrisi: Her alt dizi bir kısıtı temsil eder.
        A: [[10.0, 9.0], [3.0, 4.0]],
        // Sağ taraf (RHS) değerleri.
        b: [5.0, 6.0],
        // Amaç fonksiyonundaki değişken katsayıları.
        C: [7.0, 8.0],
        // Başlangıçta temel değişkenlerin indeksleri.
        basicVars: [2, 3],
        // Başlangıçta temel olmayan değişkenlerin indeksleri.
        nonBasicVars: [0, 1],
        // Temel değişkenlerin amaç fonksiyonu katsayıları (başlangıçta sıfır).
        C_B: [0.0, 0.0],
        // Başlangıç tablosu: İlk iki kısıt ve amaç fonksiyonu satırı.
        tableau: [
            [0.0, 2.0, 1.0, 2.0, 5.0],
            [0.0, 3.0, 3.0, 4.0, 6.0],
            [0.0, 0.0, -7.0, -8.0, 0.0]
        ]
    )
    
    var body: some View {
        VStack {
            SimplexTableView(tableau: simplex.tableau, n: simplex.n, m: simplex.m)
            // "Tabloyu Güncelle" butonu: Tıklandığında tablo güncelleme fonksiyonu çağrılır.
            Button("Tabloyu Güncelle") {
                simplex.updateTableau()
            }
            .padding()
        }
    }
}

// MARK: - SwiftUI Preview
// SwiftUI önizleme sağlayıcısı.
#Preview {
    ContentView2()
}
