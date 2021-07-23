//
//  LearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

protocol LearningDelegate{
    func saveNewLearning(categoryIndex: Int, title: String, description: String, emoji: String)
}

struct LearningView: View {
    
    var delegate: LearningDelegate?
    
    @ObservedObject var homeEnv: HomeScreenEnvironment
    @State var index = 0
    @State var isPresented = false
    
    @State var isFromCategory = false
    
    @State var title: String = ""
    @State var description: String = ""
    @State var emoji: String = ""
    
    var body: some View {
        VStack{
            
            HStack {
                
                EmojiTextField(text: $emoji, placeholder: "🍣")
                
                
                VStack{
                    
                    TextField("Insira seu título aqui", text: $title)
                        .font(.largeTitle.bold())
                    TextField("Insira sua descrição aqui", text: $description)
                        .font(.footnote)
                        
                }
            }
            
            Button("Salvar") {
                delegate?.saveNewLearning(categoryIndex: index, title: title, description: description, emoji: emoji)
                
            }
        }
        .navigationBarHidden(false)
    }
    

}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView( homeEnv: HomeScreenEnvironment())
    }
}
