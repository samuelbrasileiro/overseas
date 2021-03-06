//
//  RegisterLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 28/07/21.
//

import SwiftUI

class BindingNav: ObservableObject {
  @Published var isPresented: Bool = false
}

struct RegisterLearningView: View {
    
    var color: Color
    
    @State private var segmentedControlCells: [LocalizedStringKey] = ["Descreva", "Ordene", "Avalie"]
    @State private var segmentedControlIndex = 0
    
    @ObservedObject var env: RegisterEnvironment = RegisterEnvironment()
    
    @ObservedObject var learning: Learning
    
    @ObservedObject var nav: BindingNav
    
    @State var ammount = 0
    
    @State var isCongratulationsPresentedEnded = false
   // @State var isCongratulationsPresented = false

    @State var isCongratulationsPresented = false {
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                isCongratulationsPresentedEnded = isCongratulationsPresented
                withAnimation(.default.delay(0.35)){
                    ammount += 1
                    print(ammount)
                }
            }
        }
    }
    
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
                DescribeLearningView(color: color, learning: learning, env: env)
                    .tag(0)
                OrderLearningView(color: color, learning: learning, env: env)
                    .tag(1)
                EvaluateLearningView(color: color, learning: learning, env: env)
                    .tag(2)
            }
            
            CongratulationsView(ammount: $ammount, showCongrats: $isCongratulationsPresented)
                .frame(maxWidth: 600, maxHeight: 630)
                .animation(nil)
                .offset(y: isCongratulationsPresented ? 0 : 1000)
                .opacity(isCongratulationsPresented ? 1 : 0)
                .animation(.spring())
        
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
                    
                    env.save(to: learning)
                    isCongratulationsPresented = true
                }
            
            }
            
            
        }
        .navigationBarHidden(true)
    }
}

struct RegisterLearningView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterLearningView(color: .blue, env: RegisterEnvironment(), learning: Learning(), nav: BindingNav())
    }
}
