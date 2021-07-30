//
//  RegisterLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 28/07/21.
//

import SwiftUI

struct RegisterLearningView: View {
    
    @State private var segmentedControlCells = ["Descreva", "Ordene", "Avalie"]
    @State private var segmentedControlIndex = 0
    
//    init() {
//
//            UINavigationBar.appearance().backgroundColor = .white
//    }
    
    var body: some View {
        ZStack {
            
            LazyVGrid(columns: [GridItem(spacing: 20), GridItem(spacing: 20), GridItem(spacing: 20), GridItem(spacing: 20), GridItem(spacing: 20), GridItem(spacing: 20), GridItem(spacing: 20)], alignment: .center, spacing: 60, pinnedViews: [], content: {
                
                ForEach(0..<Int(UIScreen.main.bounds.size.width / 8), id: \.self){ _ in
                    
                    Circle()
                        .foregroundColor(Color(.systemGray4))
                        .frame(width: 10, height: 10)
                        
                }
            }).padding(.top, 200)
         
            TabView(selection: $segmentedControlIndex) {
                DescribeLearningView()
                    .tag(0)
                OrderLearningView()
                    .tag(1)
                EvaluateLearningView()
                    .tag(2)
            }
        
        }
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Color", selection: $segmentedControlIndex) {
                    ForEach(0 ..< self.segmentedControlCells.count) {
                        Text(self.segmentedControlCells[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Salvar") {
                    print("salvando")
                }
            }
        }
    }
}

struct RegisterLearningView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterLearningView()
    }
}
