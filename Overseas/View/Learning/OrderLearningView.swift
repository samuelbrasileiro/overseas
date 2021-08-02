//
//  OrderLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI
import Combine

struct OrderLearningView: View, StepsTextFieldViewDelegate {
    
    @ObservedObject var env: RegisterEnvironment
    
    var body: some View {
        VStack {
            TweetTextView(color: Color(.systemPink), height: 47){
                Text("Quais foram as etapas dessa atividade?")
            }
                
            .padding(.bottom, 100)
            
            VStack(spacing: 10){
                ForEach(0..<env.order.count, id: \.self) { index in
                    
                    StepsTextfieldView(delegate: self, textInput: $env.order[index], index: index)
                    
                    
                }
            }
            .padding(100)
        }
    }
    
    func textFieldIsEmpty(index: Int) -> String{
        if env.order.count > 0{
            print("removed ", index)
            
            let aux = env.order[index + 1]
            env.order.remove(at: index)
            
            return aux
        }
        return ""
    }
    
    func textFieldwasFilled(index: Int) {
        if index == env.order.count - 1{
            print("filled")
            env.order.append("")
        }
    }
}


class RegisterEnvironment: ObservableObject {
    
    @Published var order: [String] = [""]
    
    @Published var description: String = ""
    
    @Published var humorIndex: Int? = nil
    
    
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
                .frame(width: 18, height: 18, alignment: .leading)
                .foregroundColor(textInput.isEmpty == true ? Color(.systemPink) : Color(.systemRed))
            TextField("Insira sua próxima etapa aqui...", text: binding, onCommit: {
                
            })
        }
    }
}

struct OrderLearningView_Previews: PreviewProvider {
    static var previews: some View {
        OrderLearningView(env: RegisterEnvironment())
    }
}
