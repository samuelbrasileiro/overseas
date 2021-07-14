//
//  LearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct LearningView: View {
    
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
        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
