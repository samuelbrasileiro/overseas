//
//  DescribeLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 28/07/21.
//

import SwiftUI

struct DescribeLearningView: View {
    
    @ObservedObject var env: RegisterEnvironment
    
    var body: some View {
        VStack(alignment: .leading) {
            TweetTextView(color: Color(.systemPink), maxHeight: 47){
                Text("O que você aprendeu nessa atividade?")
            }
            
            .padding(.bottom, 100)
            
            TweetTextView(color: Color(.systemRed), maxHeight: 302, alignment: .leading){
                TextEditor(text: $env.description)
                        .frame(maxHeight: 290)
                        .padding(.top)
                        
                        .padding([.bottom,.trailing], 10)
                
            }
            
        }
    }
}

struct DescribeLearningView_Previews: PreviewProvider {
    static var previews: some View {
        DescribeLearningView(env: RegisterEnvironment())
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
