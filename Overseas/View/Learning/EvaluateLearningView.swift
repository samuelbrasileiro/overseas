//
//  EvaluateLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI

struct EvaluateLearningView: View {
    
    @State var buttonText: [String] = ["Não foi", "Neutro", "Muito", "Bastante"]
    @State var emojiImages: [String] = ["☹️", "🤔", "😌", "😍"]
 
    
    var body: some View {
        
        VStack(alignment: .center) {
            ZStack(alignment: .leading) {
                
                TweetTextView(c: Color(.systemPink), h: 47, w: 401)
                Text("O quão agradável foi realizá-la?")
                    .padding(.leading, 95)
      
            }
            .padding(.bottom, 100)
            
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color(.systemPink))
                        .frame(width: 140, height: 140)
                        .padding([.leading, .top], 14)
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            Text(emojiImages[0])
                                .font(.system(size: 64))
                            Text(buttonText[0])
                                .font(.system(size: 16))
                        }
                        .frame(width: 140, height: 140)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .background(Circle().fill(Color(.white)))
                        .background(Circle().stroke(Color(.systemPink), lineWidth: 2))
                        
                    }
                    
                }
                .padding(12)
              
                
                ZStack {
                    Circle()
                        .foregroundColor(Color(.systemPink))
                        .frame(width: 140, height: 140)
                        .padding([.leading, .top], 14)
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            Text(emojiImages[1])
                                .font(.system(size: 64))
                            Text(buttonText[1])
                                .font(.system(size: 16))
                        }
                        .frame(width: 140, height: 140)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .background(Circle().fill(Color(.white)))
                        .background(Circle().stroke(Color(.systemPink), lineWidth: 2))
                        
                    }
                }
                .padding(12)
                ZStack {
                    Circle()
                        .foregroundColor(Color(.systemPink))
                        .frame(width: 140, height: 140)
                        .padding([.leading, .top], 14)
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            Text(emojiImages[2])
                                .font(.system(size: 64))
                            Text(buttonText[2])
                                .font(.system(size: 16))
                        }
                        .frame(width: 140, height: 140)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .background(Circle().fill(Color(.white)))
                        .background(Circle().stroke(Color(.systemPink), lineWidth: 2))
                        
                    }
                }
                .padding(12)
                
                ZStack {
                    Circle()
                        .foregroundColor(Color(.systemPink))
                        .frame(width: 140, height: 140)
                        .padding([.leading, .top], 14)
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            Text(emojiImages[3])
                                .font(.system(size: 64))
                            Text(buttonText[3])
                                .font(.system(size: 16))
                        }
                        .frame(width: 140, height: 140)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .background(Circle().fill(Color(.white)))
                        .background(Circle().stroke(Color(.systemPink), lineWidth: 2))
                        
                    }
                }
                .padding(12)
            }
            .padding(.bottom, 100)
        }
    }
}

struct EvaluateLearningView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluateLearningView()
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
