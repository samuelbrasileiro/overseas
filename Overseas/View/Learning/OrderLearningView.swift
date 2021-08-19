//
//  OrderLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 30/07/21.
//

import SwiftUI
import Combine

struct OrderLearningView: View, StepsTextFieldViewDelegate {
    
    var color: Color
    var learning: Learning
    @ObservedObject var env: RegisterEnvironment
    
    
    var body: some View {
        VStack {
            TweetTextView(color: color, maxHeight: 47){
                Text("Quais foram as etapas dessa atividade?")
                    .padding(.leading, 15)
                
            }
            .padding(.horizontal, 30)
            .padding(.top, 130)
            .padding(.bottom, 80)
            
            TweetTextView(color: color){
                List{
                    
                    ForEach(0..<env.order.count, id: \.self) { index in
                        
                        HStack {
                            Rectangle()
                                .frame(width: 18, height: 18, alignment: .leading)
                                .foregroundColor(color.opacity( env.order[index].isEmpty == true ? 0.7 : 1))
                            
                            StepsTextfieldView(color: color, delegate: self, textInput: $env.order[index], index: index)
                        }
                        
                    }
                    
                    .onMove(perform: { source, destination in
                        env.order.move(fromOffsets: source, toOffset: destination)
                        
                    })
                    
                }
                .padding()
                .onAppear{
                    if learning.steps != nil {
                        env.order = learning.steps!
                        env.order.append("")
                    }
                    
                }
                
            }
            .frame(maxHeight: 400)
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
    
    func save(to learning: Learning){
        order.removeLast()
        learning.detail = description
        learning.steps = order
        learning.humor = NSDecimalNumber(integerLiteral: humorIndex ?? 0)
        
        do{
            try AppDelegate.viewContext.save()
        }catch{
            print(error)
        }
    }
}



protocol StepsTextFieldViewDelegate{
    func textFieldIsEmpty(index: Int) -> String
    func textFieldwasFilled(index: Int)
}


struct StepsTextfieldView: View {
    
    var color: Color
    
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
        
        
        TextField("Insira sua próxima etapa aqui...", text: binding)
            .textFieldStyle(PlainTextFieldStyle())
        
    }
}

//struct OrderLearningView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderLearningView(color: .blue, env: RegisterEnvironment())
//    }
//}
