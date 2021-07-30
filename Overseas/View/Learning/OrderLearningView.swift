//
//  OrderLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI
import Combine

struct OrderLearningView: View, StepsTextFieldViewDelegate {
    
    @ObservedObject var steps: Steps = Steps()
    //@State var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                TweetTextView(c: Color(.systemPink), h: 47, w: 478)
                Text("Quais foram as etapas dessa atividade?")
                    .padding(.leading, 95)
            }
            .padding(.bottom, 100)
            
            
            ForEach(0..<steps.list.count, id: \.self) { index in
                
                StepsTextfieldView(delegate: self, textInput: $steps.list[index], index: index)
                
            }
        }
    }
    
    func textFieldIsEmpty(index: Int) -> String{
        if steps.list.count > 0{
            print("removed ", index)
            
            let aux = steps.list[index + 1]
            steps.list.remove(at: index)
            
            return aux
        }
        return ""
    }
    
    func textFieldwasFilled(index: Int) {
        if index == steps.list.count - 1{
            print("filled")
            steps.list.append("")
        }
    }
}


class Steps: ObservableObject {
    
    @Published var list: [String] = [""]
}


protocol StepsTextFieldViewDelegate{
    func textFieldIsEmpty(index: Int) -> String
    func textFieldwasFilled(index: Int)
}


struct StepsTextfieldView: View {
    
    var delegate: StepsTextFieldViewDelegate
    
    
    @Binding var textInput: String
    
    
    var index: Int
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.textInput
        }, set: {
            //DIDSET
            if textInput.count > 0 && $0.isEmpty{
                self.textInput =  delegate.textFieldIsEmpty(index: index)
                
            }
            else if textInput.count == 0 && !$0.isEmpty{
                delegate.textFieldwasFilled(index: index)
                self.textInput = $0
            }
            else{
                self.textInput = $0
            }
            
        })
        
        HStack {
            Rectangle()
                .frame(width: 25, height: 25, alignment: .leading)
                .foregroundColor(textInput.isEmpty == true ? Color(.systemPink) : Color(.systemRed))
            TextField("Insira sua \(index + 1)ª etapa aqui...", text: binding, onCommit: {
                
            })
        }
    }
}

struct OrderLearningView_Previews: PreviewProvider {
    static var previews: some View {
        OrderLearningView()
    }
}
