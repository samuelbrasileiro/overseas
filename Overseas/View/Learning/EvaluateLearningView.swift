//
//  EvaluateLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI

struct EvaluateLearningView: View {
    
    var color: Color
    var learning: Learning
    @ObservedObject var env: RegisterEnvironment
    
    
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
                    let humor = Humor(rawValue: index)
                    
                    Button(action: {
                        env.humorIndex = index
                    }) {
                        TweetTextView(color: color.opacity(isSelected ? 1 : 0.7), maxHeight: 140, maxWidth: 140, alignment: .center){
                            
                            VStack {
                                Text(humor!.emoji)
                                    .font(.system(size: 64))
                                Text(humor!.text)
                                    .font(.system(size: 16, weight: isSelected ? .bold : .regular, design: .default))
                            }
                            .accentColor(.primary)
                            
                        }
                    }
                    .onAppear{
                        if learning.humor != nil {
                            env.humorIndex = Int(learning.humor!)
                        }
                        
                    }
                    
                    
                    
                }
                
                
            }
            .padding(.bottom, 100)
        }
        .animation(.spring())
    }
}

//struct EvaluateLearningView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluateLearningView(color: .green, env: RegisterEnvironment())
//            .previewLayout(.fixed(width: 1080, height: 810))
//            .environment(\.horizontalSizeClass, .compact)
//            .environment(\.verticalSizeClass, .compact)
//    }
//}
