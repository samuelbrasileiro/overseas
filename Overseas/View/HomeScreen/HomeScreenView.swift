//
//  ContentView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 06/07/21.
//

import SwiftUI

struct HomeScreenNavigationView: View { //view
    @ObservedObject var env = HomeScreenEnvironment()
    
    @State var isPresented = false
    
    var body: some View {
        
        ZStack{
            NavigationView{
                SideBarView(env: env)
                    .accentColor(.clear)

                HomeScreenView(env: env)

            }
            
            Rectangle().fill(Color.gray).opacity((env.didSelectNewCategory || env.didSelectNewLearning) ? 0.3 : 0)
            CreateNewCategoryView(env: env)
                .frame(maxWidth: 600, maxHeight: 500)
                .offset(y: env.didSelectNewCategory ? 0 : 1000)
                .animation(.spring())
                .opacity(env.didSelectNewCategory ? 1 : 0)
            
            CreateNewLearningView(env: env)
                .frame(maxWidth: 600, maxHeight: 500)
                .offset(y: env.didSelectNewLearning ? 0 : 1000)
                .animation(.spring())
                .opacity(env.didSelectNewLearning ? 1 : 0)
        }
    }
}
struct HomeScreenView: View{
    @ObservedObject var env = HomeScreenEnvironment()
    var body: some View{
        let fixed = env.fixedLearnings
        let all = env.allLearnings
                ZStack{
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Text("Fixados").underline()
                                    .font(.largeTitle.bold())
                                
                                VStack(alignment: .trailing){
                                    HStack(spacing: 40){
                                        ForEach(fixed[0..<(fixed.count < 3 ? fixed.count : 3)]){ l in
                                            HomeScreenLearningItemView(learning: l, color: Color.categoryColors[l.category!.colorIndex]).frame(width: 240, height: 240)
                                                .scaleEffect(0.8)
                                                .frame(width: 240*0.8, height: 240*0.8)
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
                                        .frame(maxHeight: 280)
                                        .padding([.top, .bottom, .trailing],20)
                                        
                                    }else{
                                        NavigationLink(destination: GridLearningView(isFixed: true)){
                                            HStack{
                                                Text("Ver todos")
                                                    .bold()
                                                Text(Image(systemName: "chevron.right"))
                                                    .bold()
                                                
                                            }
                                            .padding(.top)
                                        }.accentColor(.primary)
                                        .opacity(fixed.count > 3 ? 1 : 0)
                                        
                                    }
                                    
                                }
                            }
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Meus Aprendizados").underline()
                                        .font(.largeTitle.bold())

                                    Button(action: {env.didSelectNewLearning = true}){
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.primary)
                                            .padding(10)
                                            .overlay(Rectangle().stroke(Color.primary, lineWidth: 2))
                                            .padding(.leading)
                                    }
                                }
                                VStack(alignment: .trailing){
                                    HStack(spacing: 40){
                                        ForEach(all[0..<(all.count < 3 ? all.count : 3)]){ l in
                                            
                                            HomeScreenLearningItemView(learning: l, color: Color.categoryColors[l.category!.colorIndex])
                                                .frame(width: 240, height: 240)
                                                .scaleEffect(0.8)
                                                .frame(width: 240*0.8, height: 240*0.8)
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
                                        
                                        NavigationLink(destination: GridLearningView(isFixed: false)){
                                            HStack{
                                                Text("Ver todos")
                                                    .bold()
                                                Text(Image(systemName: "chevron.right"))
                                                    .bold()
                                                
                                            }
                                            .padding(.top)
                                            
                                        }.accentColor(.primary)
                                        
                                        .opacity(all.count > 3 ? 1 : 0)
                                    }
                                }
                                
                            }
                            
                        }
                        .padding(.leading)

                    .animation(.spring())
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                //.environment(\.locale, .init(identifier: "en"))
            }

            
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenNavigationView()
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
