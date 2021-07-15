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
                                ForEach(fixed[0..<(fixed.count < 3 ? fixed.count : 3)]){ l in
                                    HomeScreenLearningItemView(learning: l, color: [.red, .blue, .blue, .yellow].randomElement()!).frame(width: 240, height: 240)
                                }
                            }
                            if(fixed.count==0){
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Text("Você ainda não fixou nenhum aprendizado")
                                        Spacer()
                                    }
                                    Spacer()
                                    
                                }.background(Color(.systemGray6))
                                .padding(20)
                                
                            }else{
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
                                ForEach(all[0..<(all.count < 3 ? all.count : 3)]){ l in
                                    HomeScreenLearningItemView(learning: l, color: [.red, .blue, .blue, .yellow].randomElement()!)
                                        .frame(width: 240, height: 240)
                                }
                            }
                            
                            if(all.count==0){
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Text("Você ainda não adicionou nenhum aprendizado")
                                        Spacer()
                                    }
                                    Spacer()
                                    
                                }.background(Color(.systemGray6))
                                .padding(20)
                            }else{
                                
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
                }
                .padding(.leading)
                Spacer()
            }
            .disabled(env.didSelectNewCategory)
            
            CreateNewCategoryView(env: env)
                .frame(maxWidth: 600, maxHeight: 500)
                .offset(y: env.didSelectNewCategory ? 0 : 1000)
                .animation(.spring())
                .opacity(env.didSelectNewCategory ? 1 : 0)
            
            
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
