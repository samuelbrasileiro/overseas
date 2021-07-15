//
//  CategoryView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CategoryView: View {
    let env: CategoryEnvironment
    var body: some View {
        VStack{
            HStack{
                Text(env.category.name ?? "Categoria").underline()
                    .font(.largeTitle.bold())
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
            }
            .padding(.leading)
            .padding([.leading, .top], 40)
            .padding(.top, 40)
            
            LazyVGrid(columns: [GridItem(),GridItem()], content: {
                ForEach(env.allLearnings[0..<4]){ learning in
                    CategoryLearningView(learning: learning, color: [.red,.blue,.green].randomElement()!)
                        .padding()
                }
            })
            .padding(.horizontal, 40)
            Spacer()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(env: CategoryEnvironment())
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
