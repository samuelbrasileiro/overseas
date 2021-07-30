//
//  StepsTextfieldView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI

struct StepsTextfieldView: View {
    
    @State var textInput: String = ""
    @State var isEmpty: Bool = true
    @State var stepsStrings: [String] = [""]
    @Binding var text: String
    @Binding var index: Int
    
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 25, height: 25, alignment: .leading)
                .foregroundColor(isEmpty == true ? Color(.systemPink) : Color(.systemRed))
            TextField("Insira sua primeira etapa aqui...", text: $textInput,
                      onCommit:  {
                        if textInput.isEmpty {
                            self.isEmpty = true
                        } else {
                            self.isEmpty = false
                        }
                      })
        }
    }
}
//
//struct StepsTextfieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepsTextfieldView(, text: <#Binding<String>#>)
//    }
//}
