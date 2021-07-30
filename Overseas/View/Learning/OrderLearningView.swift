//
//  OrderLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI

struct OrderLearningView: View {
    
    @State var stepsCount: Int = 1
    @State var stepsStrings: [String] = [""]

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                TweetTextView(c: Color(.systemPink), h: 47, w: 478)
                Text("Quais foram as etapas dessa atividade?")
                    .padding(.leading, 95)
            }
            .padding(.bottom, 100)
        
            
            ForEach(0..<stepsStrings.count, id: \.self) { index in
//                HStack {
//                    Rectangle()
//                        .frame(width: 25, height: 25, alignment: .leading)
//                        .foregroundColor(isEmpty == true ? Color(.systemPink) : Color(.systemRed))
//                    TextField("Insira sua primeira etapa aqui...", text: $textInput,
//                              onCommit:  {
//                                if textInput.isEmpty {
//                                    self.isEmpty = true
//                                } else {
//                                    self.isEmpty = false
//                                }
//                              })
//                }
                
            }
        }
    }
}

struct OrderLearningView_Previews: PreviewProvider {
    static var previews: some View {
        OrderLearningView()
    }
}
