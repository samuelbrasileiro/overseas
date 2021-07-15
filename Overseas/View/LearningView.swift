//
//  LearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct LearningView: View {
    
    @State var isPresented = false
    
    @ObservedObject var env = HomeScreenEnvironment()
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
                saveNewLearning()
                print(env.allLearnings)
            }
        }
        .navigationBarHidden(false)
    }
    
    func saveNewLearning() {
        if title.isEmpty || description.isEmpty {
            return
        }
        
        let context = AppDelegate.viewContext
        let learning = Learning(name: self.title, descriptionText: self.description, emoji: emoji, estimatedTime: 0, text: "", context: context)
        env.allLearnings.append(learning)
        do {
            try context.save()
            
        } catch {
            print(error)
        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
