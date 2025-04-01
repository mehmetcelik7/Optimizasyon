import SwiftUI



struct ContentView: View {
    @State private var yValuesInput: String = ""
    @State private var constraintCount: Int = 3
    @State private var dynamicData: [[TableCell]] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                TextField("Maks/Min katsayılarını girin", text: $yValuesInput)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Kısıt sayısını girin", value: $constraintCount, formatter: NumberFormatter())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Tabloyu Güncelle") {
                    dynamicData = generateTableData(yValues: yValuesInput.split(whereSeparator: \.isWhitespace).map { String($0) }, constraintCount: constraintCount)
                    
                }
                ForEach(0..<dynamicData.count, id: \.self) { rowIndex in
                    HStack(spacing: 0) {
                        ForEach(0..<dynamicData[rowIndex].count, id: \.self) { cellIndex in
                            let cell = dynamicData[rowIndex][cellIndex]
                            if rowIndex == 0 && cellIndex == 0 {
                                TextField("", text: $dynamicData[rowIndex][cellIndex].content)
                                    .frame(minWidth: 315, maxWidth: .infinity, minHeight: 45)                               .multilineTextAlignment(.center)
                                    .background(cell.color)
                                    .border(Color.black, width: 1)
                            } else if rowIndex == 0 && (cellIndex == 1 || cellIndex == 2) {
                                EmptyView()
                            } else if rowIndex == dynamicData.count - 1 && cellIndex == 0 {
                                TextField("", text: $dynamicData[rowIndex][cellIndex].content)
                                    .frame(width: 360, height: 45)
                                    .multilineTextAlignment(.center)
                                    .background(cell.color)
                                    .border(Color.black, width: 1)
                            } else if rowIndex == dynamicData.count - 1 && (cellIndex == 1 || cellIndex == 2) {
                                EmptyView()
                            } else {
                                TextField("", text: $dynamicData[rowIndex][cellIndex].content)
                                    .frame(minWidth: 45, maxWidth: .infinity, minHeight: 45)
                                    .multilineTextAlignment(.center)
                                    .background(cell.color)
                                    .border(Color.black, width: 1)
                            }
                        }
                    }
                }
                
                
            }.frame(width: 720, height: 480, alignment: .center)
        }
        
    }
}

#Preview {
    ContentView()
}
