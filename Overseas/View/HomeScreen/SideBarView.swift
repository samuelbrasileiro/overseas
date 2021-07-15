//
//  SideBarView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import SwiftUI


struct SideBarView: View {
    
    @ObservedObject var env: HomeScreenEnvironment
    
    @State var isPresented = false
    
    var body: some View {
        let categories = env.categories
        VStack(alignment: .leading){
            
            
            Button(action:{
            }){
                HStack{
                    Text("Categorias")
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.down")
                    
                }.padding(10)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                .padding(.horizontal)
            }.accentColor(.black)
            
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    
                    ForEach(categories){c in
                        NavigationLink(destination: CategoryView(env: CategoryEnvironment(category: c))){
                            Text(c.name ?? "")
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    HStack{
                        Button(action:{
                            env.didSelectNewCategory = true
                        }){
                            Text(Image(systemName: "plus"))
                                .padding(5)
                                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                                .padding(.leading)
                            Text("Adicionar categoria")
                        }.accentColor(.black)
                        
                        
                    }
                }
                Spacer()
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
