//
//  DescribeLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 28/07/21.
//

import SwiftUI

struct DescribeLearningView: View {
    
    @State var textFieldInput: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                TweetTextView(c: Color(.systemPink), h: 47, w: 478)
                Text("O que você aprendeu nessa atividade?")
                    .padding(.leading, 95)
            }
            .padding(.bottom, 100)
            
            ZStack(alignment: .center) {
                TweetTextView(c: Color(.systemRed), h: 302, w: 921)
                TextField("", text: $textFieldInput)
            }
        }
    }
}

struct DescribeLearningView_Previews: PreviewProvider {
    static var previews: some View {
        DescribeLearningView()
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
