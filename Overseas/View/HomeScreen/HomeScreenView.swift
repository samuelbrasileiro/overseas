//
//  ContentView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 06/07/21.
//

import SwiftUI

struct HomeScreenNavigationView: View { //view
    @ObservedObject var env: HomeScreenEnvironment
    
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
                .frame(maxWidth: 600, maxHeight: 630)
                .offset(y: env.didSelectNewLearning ? 0 : 1000)
                .animation(.spring())
                .opacity(env.didSelectNewLearning ? 1 : 0)
        }
    }
}
struct HomeScreenView: View{
    func atualize(geo: GeometryProxy)->some View{
        print(geo.size.width)
        return EmptyView()
    }
    @ObservedObject var env: HomeScreenEnvironment
    var body: some View{
        let fixed = env.fixedLearnings
        let all = env.allLearnings
        GeometryReader { (geometry) in
            let maxCount = geometry.size.width > 900 ? 4 : 3
            ZStack{
                atualize(geo: geometry)
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Fixados").underline()
                            .font(.largeTitle.bold())
                        
                        VStack(alignment: .trailing){
                            HStack(spacing: 40){
                                ForEach(fixed[0..<(fixed.count < maxCount ? fixed.count : maxCount)]){ l in
                                    HomeScreenLearningItemView(learning: l, color: Color.categoryColors[l.category!.colorIndex], delegate: env).frame(width: 240, height: 240)
                                        .scaleEffect(0.8)
                                        .frame(width: 240*0.8, height: 240*0.8)
                                }
                            }
                            if(fixed.count==0){
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Text("Voc?? ainda n??o fixou nenhum aprendizado")
                                        Spacer()
                                    }
                                    Spacer()
                                    
                                }.background(Color(.systemGray6))
                                .frame(maxHeight: 280)
                                .padding([.top, .bottom, .trailing],20)
                                
                            }else{
                                NavigationLink(destination: GridLearningView(isFixed: true, env: env)){
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
                        .padding(.leading)

                    }
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Meus Aprendizados").underline()
                                .font(.largeTitle.bold())
                            
                            Button(action: {
                                env.lastCategory = 0
                                env.didSelectNewLearning = true
                            }){
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
                                ForEach(all[0..<(all.count < maxCount ? all.count : maxCount)]){ l in
                                    
                                    HomeScreenLearningItemView(learning: l, color: Color.categoryColors[l.category!.colorIndex], delegate: env)
                                        .frame(width: 240, height: 240)
                                        .scaleEffect(0.8)
                                        .frame(width: 240*0.8, height: 240*0.8)
                                }
                                
                                Spacer()
                            }
                            
                            if(all.count==0){
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Text("Voc?? ainda n??o adicionou nenhum aprendizado")
                                        Spacer()
                                        
                                    }
                                    Spacer()
                                    
                                }.background(Color(.systemGray6))
                                .padding([.top, .bottom, .trailing],20)
                            }else{
                                
                                NavigationLink(destination: GridLearningView(isFixed: false, env: env)){
                                    HStack{
                                        Text("Ver todos")
                                            .bold()
                                        Text(Image(systemName: "chevron.right"))
                                            .bold()
                                        
                                    }
                                    .padding(.top)
                                    .padding(.trailing, 25)
                                    
                                }.accentColor(.primary)
                                
                                .opacity(all.count > 3 ? 1 : 0)
                            }
                        }
                        
                        .padding(.leading)
                        
                        .animation(.spring())
                        
                        
                    }
                    
                }
                .padding(.leading)
                
                .animation(.spring())
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .background(NavigationConfigurator { nc in
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.clear]
            })
            
        }
    }
    
    
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenNavigationView(env: HomeScreenEnvironment())
            .previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
