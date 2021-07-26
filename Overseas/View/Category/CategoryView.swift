//
//  CategoryView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CategoryView: View {
    @State var index: Int
    @ObservedObject var homeEnv: HomeScreenEnvironment
    
    @State var isPresented = false
    
    
    var body: some View {
        let learnings = homeEnv.getLearningsFromCategory(index)
        VStack{
            HStack{
                Text(homeEnv.categories[index].name ?? "Categoria").underline()
                    .font(.largeTitle.bold())
                NavigationLink(destination: LearningView(delegate: homeEnv, homeEnv: homeEnv,index: index, isFromCategory: true)){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                        .padding(10)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                        .padding(.leading)
                }
                .accentColor(.black)
                
                Spacer()
            }
            .padding(.leading)
            .padding([.leading, .top], 40)
            .padding(.top, 40)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(),GridItem()], content: {
                    ForEach(learnings[0..<learnings.count]){ learning in
                        CategoryLearningView(learning: learning, color: Color.categoryColors[homeEnv.categories[index].colorIndex])
                            .padding()
                    }
                })
            }
            .padding(.horizontal, 40)
            Spacer()
        }
        .navigationBarHidden(false)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(index: 0, homeEnv: HomeScreenEnvironment())
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
