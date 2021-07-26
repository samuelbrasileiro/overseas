//
//  GridLearningView.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 13/07/21.
//

import SwiftUI

struct GridLearningView: View {
    
    @State var isPresented = false
    
    @ObservedObject var env = HomeScreenEnvironment()
    var isFixed: Bool = false
    var learnings: [Learning] = []
    var title: LocalizedStringKey = ""
    
    init(isFixed: Bool){
        self.isFixed = isFixed
        
        if isFixed == true {
            learnings = env.fixedLearnings
            title = "Fixados"
        } else {
            learnings = env.allLearnings
            title = "Meus Aprendizados"
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(title).underline()
                    .font(.largeTitle.bold())
                    .padding(.leading)
                    
                Button(action:{
                    
                }){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                        .padding(10)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                        .padding(.leading)
                }
                Spacer()
                
            }.padding()
            .padding(.top, 30)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(spacing: 20), GridItem(spacing: 20)], alignment: .center, spacing: 20, pinnedViews: [], content: {
                    
                    ForEach(learnings, id:\.self){ learning in
                        
                        CategoryLearningView(learning: learning, color: Color.categoryColors[learning.category!.colorIndex])
                            
                            
                    }
                }).padding(.vertical)
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(false)
    }
}

struct GridLearningView_Previews: PreviewProvider {
    static var previews: some View {
        GridLearningView(isFixed: false)
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
