//
//  ContentView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 06/07/21.
//

import SwiftUI

struct HomeScreenView: View { //view
    @ObservedObject var env = HomeScreenEnvironment()
    
    var body: some View {
        let categories = env.categories
        let fixed = env.fixedLearnings
        let all = env.allLearnings
        ZStack{
            HStack {
                SideBarView(env: env)
                    .frame(maxWidth: 270)
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Fixados").underline()
                            .font(.largeTitle.bold())
                        
                        VStack(alignment: .trailing){
                            HStack(spacing: 40){
                                ForEach(fixed[0..<(categories.count < 3 ? categories.count : 3)]){ l in
                                    HomeScreenLearningItemView(learning: l, color: [.red, .blue, .blue, .yellow].randomElement()!).frame(width: 240, height: 240)
                                }
                            }
                            Button(action:{
                                
                            }){
                                HStack{
                                    Text("Ver todos")
                                        .bold()
                                    Text(Image(systemName: "chevron.right"))
                                        .bold()
                                    
                                }
                                .padding(.top)
                            }.accentColor(.black)
                            
                        }
                    }
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Meus Aprendizados").underline()
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
                        }
                        VStack(alignment: .trailing){
                            HStack(spacing: 40){
                                ForEach(all[0..<(categories.count < 3 ? categories.count : 3)]){ l in
                                    HomeScreenLearningItemView(learning: l, color: [.red, .blue, .blue, .yellow].randomElement()!)
                                        .frame(width: 240, height: 240)
                                }
                            }
                            Button(action:{
                                
                            }){
                                HStack{
                                    Text("Ver todos")
                                        .bold()
                                    Text(Image(systemName: "chevron.right"))
                                        .bold()
                                    
                                }
                                .padding(.top)
                            }.accentColor(.black)
                        }
                    }
                }
                .padding(.leading)
                Spacer()
            }
            .disabled(env.didSelectNewCategory)
            if(env.didSelectNewCategory){
                CreateNewCategoryView(env: env)
                    .frame(maxWidth: 600, maxHeight: 500)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
