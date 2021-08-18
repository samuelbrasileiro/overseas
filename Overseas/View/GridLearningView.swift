//
//  GridLearningView.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 13/07/21.
//

import SwiftUI

struct GridLearningView: View {
    
    var isFixed: Bool = false
    @ObservedObject var env: HomeScreenEnvironment

    func checkIsFixed()->[Learning]{
        var learnings: [Learning] = []
        if isFixed == true {
            learnings = env.fixedLearnings
        } else {
            learnings = env.allLearnings
        }
        return learnings
    }
    func checkIsFixedText()->LocalizedStringKey{
        
        if isFixed == true {
            return "Fixados"
        } else {
            return "Meus Aprendizados"
        }
        
    }
    var body: some View {
        VStack{
        let learnings = checkIsFixed()
            HStack{
                Text(checkIsFixedText()).underline()
                    .font(.largeTitle.bold())
                    .padding(.leading)
                    
                Button(action:{
                    
                }){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                        .padding(10)
                        .overlay(Rectangle().stroke(Color.primary, lineWidth: 2))
                        .padding(.leading)
                }
                Spacer()
                
            }.padding()
            .padding(.top, 30)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(spacing: 20), GridItem(spacing: 20)], alignment: .center, spacing: 20, pinnedViews: [], content: {
                    
                    ForEach(learnings, id:\.self){ learning in
                        
                        CategoryLearningView(learning: learning, color: Color.categoryColors[learning.category!.colorIndex], delegate: env)
                            
                            
                    }
                }).padding(.vertical)
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle(isFixed ? "Fixados" : "Meus Aprendizados")
    }
}

struct GridLearningView_Previews: PreviewProvider {
    static var previews: some View {
        GridLearningView(isFixed: false, env: HomeScreenEnvironment())
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
