//
//  EvaluateLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI

struct EvaluateLearningView: View {
    
    var color: Color
    
    @ObservedObject var env: RegisterEnvironment
    
    @State var buttonText: [LocalizedStringKey] = ["Não foi", "Neutro", "Muito", "Bastante"]
    @State var emojiImages: [String] = ["☹️", "🤔", "😌", "😍"]
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            TweetTextView(color: color, maxHeight: 47){
                Text("O quão agradável foi realizá-la?")
                    .padding(.leading, 15)

            }
            .padding(.horizontal, 30)
            .padding(.bottom, 100)
            
            HStack(spacing: 40) {
                ForEach(0..<4, id: \.self){ index in
                    
                    let isSelected = env.humorIndex == index
                    
                    
                    Button(action: {
                        env.humorIndex = index
                    }) {
                        TweetTextView(color: color.opacity(isSelected ? 1 : 0.7), maxHeight: 140, maxWidth: 140, alignment: .center){
                            VStack {
                                Text(emojiImages[index])
                                    .font(.system(size: 64))
                                Text(buttonText[index])
                                    .font(.system(size: 16, weight: isSelected ? .bold : .regular, design: .default))
                            }
                            .accentColor(.primary)
                            
                        }
                    }
                    
                    
                    
                }
                
                
            }
            .padding(.bottom, 100)
        }
        .animation(.spring())
    }
}

struct EvaluateLearningView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluateLearningView(color: .green, env: RegisterEnvironment())
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
