//
//  ContentView.swift
//  Optimizasyon
//
//  Created by mehmet Çelik on 26.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Grid {
                Spacer()
               
                VStack {
                    
                  HStack{
                      GridRow{
                          Color.blue.opacity(0.6)
                          
                      }
                      GridRow{
                          Color.black.opacity(0.4)
                      }
                      GridRow{
                          Color.red.opacity(0.6)
                      }
                   } //hstack bitiş
                    GridRow{
                        Color.green.opacity(0.6)
                    }
                    GridRow{
                        Color.green.opacity(0.6)
                    }
                    GridRow{
                        Color.green.opacity(0.6)
                    }
                }// Vstack bitiş
                    
                
            }
        }
    }
}

#Preview {
    ContentView()
}
