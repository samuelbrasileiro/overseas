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
    @State var description: String = ""
    @State var emoji: String = ""
    @State var selectedCategoryIndex: Int = 0
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
                    env.saveNewLearning(categoryIndex: selectedCategoryIndex, title: name, description: description, emoji: emoji)
                    name = ""

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
                HStack{
                    ForEach(0..<env.categories.count, id: \.self){ index in
                        ZStack{
                            Text(env.categories[index].name ?? "")
                                .padding(5)
                                .background(Color.categoryColors[env.categories[index].colorIndex])
                                .onTapGesture {
                                    self.selectedCategoryIndex = index
                                }
                            if(self.selectedCategoryIndex==index){
                                Image(systemName: "checkmark.circle.fill")
                                    //.foregroundColor(Color.categoryColors[env.categories[index].colorIndex])
                                    .foregroundColor(.white)
                                   
                            }
                        }
                        
                    }
                    
                }
                .padding(20)

            }
            .background(Color(.white))
            
            Text("Aprendizado")
                .font(.title2.bold())
                .padding()
            
            HStack{
                
                EmojiTextField(text: $emoji, placeholder: "🧐")
                    //.padding(.leading, 30)
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Circle().stroke(Color(.systemGray3)))
                    .padding(.vertical, 8)
                    .padding(.leading, 16)
             
                TextField("Adicione um título", text: $name)
                    .padding(.leading, 5)
                    //.padding(.leading, 50)
            }
            .background(Color(.white))
           
            
            HStack{
                Text("O título do aprendizado é uma forma rápida e resumida de representar o aprendizado.")
                    .padding(.leading)
                    .padding(.top, 5)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    
            }
            
            Text("Descrição")
                .font(.title2.bold())
                .padding()
            
            TextField("Adicione uma descrição", text: $description)
            .padding(20)
            .background(Color(.white))
            
           
            HStack{
                Text("A descrição ajuda a compreender as especificidades dos aprendizados.")
                    .padding(.leading)
                    .padding(.top, 5)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 50)
            
        
        }
        .background(Color(.systemGray6))
        
        Spacer()
    }
}

//struct CreateNewLearningView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewLearningView()
//    }
//}
