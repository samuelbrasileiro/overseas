//
//  SideBarView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import SwiftUI

enum Screen: Hashable {
    case homescreen
    case category(index:Int)
}

struct SideBarView: View {
    
    @ObservedObject var env: HomeScreenEnvironment
    @State var categoriesIsOpen: Bool = false
    
    @State var isPresented = false
    @State var state: Screen? = .homescreen
    
    var body: some View {
        let categories = env.categories
        List{
            
            NavigationLink(destination: HomeScreenView(env: env), tag: Screen.homescreen, selection: $state){
                HStack{
                    Label("Homescreen", systemImage: "house")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    Spacer()
                }
                

            }
            .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            .font(Font.headline.weight(state == Screen.homescreen ? .bold : .regular))
            .foregroundColor(.black)
            .padding()
            
            Button(action:{
                categoriesIsOpen = !categoriesIsOpen
            }){
                HStack{
                    Text("Categorias")
                        .bold()
                    Spacer()
                    
                    
                    Image(systemName: "chevron.right")
                        .rotationEffect(.init(degrees: categoriesIsOpen ? 90.0 : 0))
                        .animation(.spring())
                        
                            
                    
                    
                }.padding(10)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                .padding(.horizontal)
            }

            Group{
                ForEach((0..<(categoriesIsOpen ? categories.count : 0)), id: \.self){ index in
                    NavigationLink(destination: CategoryView(index: index, homeEnv: env),  tag: Screen.category(index: index), selection: $state){
                        
                        Text(categories[index].name ?? "")
                         
                    }
                    .font(Font.headline.weight(state == Screen.category(index: index) ? .bold : .regular))
                    .foregroundColor(.black)
                    
                }
            }
            .padding(.leading, 30)
            
            
            Button(action:{
                env.didSelectNewCategory = true
            }){
                HStack{
                    Text(Image(systemName: "plus"))
                        .padding(5)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                        .padding(.leading)
                    Text("Adicionar Categoria")
                }
            }
        }
        .navigationTitle("Menu")
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView(env: HomeScreenEnvironment())
            .previewLayout(.fixed(width: 270, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
