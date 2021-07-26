//
//  CreateNewLearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CreateNewLearningView: View {
    @State var isPresented = false
    @ObservedObject var env: HomeScreenEnvironment
    
    @State var name: String = ""

    
    @State var colorIndex: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                Button(action:{
                    env.didSelectNewLearning = false
                    name = ""
                }){
                    Text("Cancelar")
                }
                Spacer()
                Text("Adicionar Aprendizado")
                    .bold()
                Spacer()
                Button(action:{
                    env.didSelectNewLearning = false
                    //env.createNewCategory(name: name, colorIndex: colorIndex)
                    name = ""
                    //env.categoriesIsOpen = true

                }){
                    Text("Salvar")
                        .bold()
                        
                }.disabled(name == "" ? true : false)
                
                
            }
            .padding()
            .background(Color(.white))
            
            Text("Categoria")
                .font(.title2.bold())
                .padding()
            
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(0..<env.categories.count, id: \.self){ index in
                        Text(env.categories[index].name ?? "")
                    }
                    
                }
            }
            
            Text("Aprendizado")
                .font(.title2.bold())
                .padding()
            
            TextField("Adicione um título", text: $name)
            .padding()
            .background(Color(.white))
            
            HStack{
                Spacer()
                Text("O título do aprendizado é uma forma rápida e resumida de representar o aprendizado.")
                .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Text("Descrição")
                .font(.title2.bold())
                .padding()
            
            TextField("Adicione uma descrição", text: $name)
            .padding()
            .background(Color(.white))
            
           
            HStack{
                Spacer()
                Text("Os aprendizados referentes a essa categoria ficarão sinalizadas com a cor escolhida")
                .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Spacer()
        }
        .background(Color(.systemGray6))
    }
}

//struct CreateNewLearningView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewLearningView()
//    }
//}
