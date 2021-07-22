//
//  SideBarView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import SwiftUI


struct SideBarView: View {
    
    @ObservedObject var env: HomeScreenEnvironment
    @State var categoriesIsOpen: Bool = false
    
    @State var isPresented = false
    
    var body: some View {
        let categories = env.categories
        List{
            
            NavigationLink(destination: HomeScreenView(env: env)){
                HStack{
                    Text("HomeScreen")
                        
                        .bold()
                    
                    Spacer()
                }
                .listRowBackground(Color(.systemGray6))
                .padding(10)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            }
            .listRowBackground(Color(.systemGray6))
            //.padding(.horizontal)
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
            }.accentColor(.black)

        
            ForEach(categories[0..<(categoriesIsOpen ? categories.count : 0)]){c in
                NavigationLink(destination: CategoryView(env: CategoryEnvironment(category: c))){
                    Text(c.name ?? "")
                        .bold()
                        .foregroundColor(.black)
                        .accentColor(.clear)
                }
                
                
            }
            .listRowBackground(Color(.systemGray6))
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
                }.accentColor(.black)
                
            }
        }
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
