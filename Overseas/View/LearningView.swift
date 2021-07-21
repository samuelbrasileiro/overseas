//
//  LearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

protocol LearningDelegate{
    func saveNewLearning(title: String, description: String, emoji: String)
}

struct LearningView: View {
    
    var delegate: LearningDelegate?
    
    @State var isPresented = false
    
//    @ObservedObject var env = HomeScreenEnvironment()
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
                print("aaaaa")
                delegate?.saveNewLearning(title: title, description: description, emoji: emoji)
                
                //print(env.allLearnings)
            }
        }
        .navigationBarHidden(false)
    }
    

}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
