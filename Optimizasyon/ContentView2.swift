import SwiftUI

struct TableCell: Identifiable {
    var id = UUID()
    var content: String
    var color: Color = .white
}

struct ContentView: View {
    @State private var yValuesInput
    : String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TextField("y katsayılarını girin", text: $yValuesInput)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            let dynamicData = generateTableData(yValues: yValuesInput.split(separator: ",").map { String($0) })
            
            ForEach(0..<dynamicData.count, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(0..<dynamicData[rowIndex].count, id: \.self) { cellIndex in
                        let cell = dynamicData[rowIndex][cellIndex]
                        if rowIndex == 0 && cellIndex == 0 {
                            Text(cell.content)
                                .frame(width: 270, height: 45)
                                .multilineTextAlignment(.center)
                                .background(cell.color)
                                .border(Color.black, width: 1)
                        } else if rowIndex == 0 && (cellIndex == 1 || cellIndex == 2) {
                            EmptyView()
                        } else if rowIndex == dynamicData.count - 1 && cellIndex == 0 {
                            Text(cell.content)
                                .frame(width: 270, height: 45)
                                .multilineTextAlignment(.center)
                                .background(cell.color)
                                .border(Color.black, width: 1)
                        } else if rowIndex == dynamicData.count - 1 && (cellIndex == 1 || cellIndex == 2) {
                            EmptyView()
                        } else {
                            Text(cell.content)
                                .frame(minWidth: 45, maxWidth: .infinity, minHeight: 45)
                                .background(cell.color)
                                .border(Color.black, width: 1)
                        }
                    }
                }
            }
        }.frame(width: 720, height: 480, alignment: .center)
    }
}

#Preview {
    ContentView()
}
