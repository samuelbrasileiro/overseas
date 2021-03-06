//
//  CreateNewCategoryView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CreateNewCategoryView: View {
    
    let env: HomeScreenEnvironment
    
    @State var name: String = ""

    
    @State var colorIndex: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                Button(action:{
                    env.didSelectNewCategory = false
                    name = ""
                }){
                    Text("Cancelar")
                }
                Spacer()
                Text("Adicionar Categoria")
                    .bold()
                Spacer()
                Button(action:{
                    env.didSelectNewCategory = false
                    env.createNewCategory(name: name, colorIndex: colorIndex)
                    name = ""
                    env.categoriesIsOpen = true

                }){
                    Text("Salvar")
                        .bold()
                        
                }.disabled(name == "" ? true : false)
                
                
            }
            .padding()
            .background(Color(.systemBackground))
            
            Text("Categoria")
                .font(.title2.bold())
                .padding()
            
            TextField("Nome da categoria", text: $name)
            .padding()
            .background(Color(.systemBackground))
            HStack{
                Spacer()
                Text("A categoria ajuda a agrupar os aprendizados e ver o progresso em diferentes aspectos da vida")
                .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Text("Cor")
                .font(.title2.bold())
                .padding()
            
            HStack{
                
                ForEach((0..<Color.categoryColors.count)){index in
                    Button(action:{
                        self.colorIndex = index
                    }){
                        ZStack{
                            Circle()
                                .fill(Color.categoryColors[index])
                                .frame(width: 50, height: 50)
                                .padding(4)
                                .overlay(Circle().stroke().foregroundColor(Color.categoryColors[index]).opacity(index == colorIndex ? 1 : 0)
                                )
                            Text(Image(systemName: "checkmark"))
                                .foregroundColor(Color(.systemBackground))
                                .font(.system(size: 20))
                                .opacity(index == colorIndex ? 1 : 0)
                        }
                    }
                }
                Spacer()
                
            }
            .padding(.leading)
            .padding(.vertical)
            .background(Color(.systemBackground))
            HStack{
                Spacer()
                Text("Os aprendizados referentes a essa categoria ficar??o sinalizadas com a cor escolhida")
                .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Spacer()
        }
        .background(Color(.systemGray6))
    }
}

struct CreateNewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewCategoryView(env: HomeScreenEnvironment())
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 600, height: 500))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
