//
//  EvaluateLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI

struct EvaluateLearningView: View {
    
    @ObservedObject var env: RegisterEnvironment
    
    @State var buttonText: [String] = ["Não foi", "Neutro", "Muito", "Bastante"]
    @State var emojiImages: [String] = ["☹️", "🤔", "😌", "😍"]
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            TweetTextView(color: Color(.systemPink), maxHeight: 47){
                Text("O quão agradável foi realizá-la?")
            }
            
            .padding(.bottom, 100)
            
            HStack {
                ForEach(0..<4, id: \.self){ index in
                    ZStack {
                        
                        let isSelected = env.humorIndex == index
                        
                        
                        Button(action: {
                            env.humorIndex = index
                        }) {
                            ZStack{
                                Circle()
                                    .foregroundColor(Color(.systemPink).opacity(isSelected ? 1 : 0.7))
                                    .frame(width: 140, height: 140)
                                    .offset(x: 10, y: 10)
                                VStack {
                                    Text(emojiImages[index])
                                        .font(.system(size: 64))
                                    Text(buttonText[index])
                                        .font(.system(size: 16, weight: isSelected ? .bold : .regular, design: .default))
                                }
                                .frame(width: 140, height: 140)
                                .foregroundColor(.black)
                                .background(Color(.systemBackground))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(.systemPink).opacity(isSelected ? 1 : 0.7), lineWidth: 2))
                            }
                        }
                        
                    }
                    .padding(12)
                }
                
                
            }
            .padding(.bottom, 100)
        }
        .animation(.spring())
    }
}

struct EvaluateLearningView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluateLearningView(env: RegisterEnvironment())
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
