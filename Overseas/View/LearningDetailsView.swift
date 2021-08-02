//
//  LearningDetailsView.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 27/07/21.
//

import SwiftUI

protocol LearningDelegate {
    
    func saveNewLearning(categoryIndex: Int, title: String, description: String, emoji: String)
    func resetFixedLearnings()
    
}


enum Humor: Int {
    case wasNot
    case neutre
    case very
    case aLot
    case none
    
    var text: String{
        switch self {
        case .wasNot:
            return "Não Foi"
        case .neutre:
            return "Neutro"
        case .very:
            return "Muito"
        case .aLot:
            return "Bastante"
        default:
            return ""
        }
    }
    
    var emoji: String {
        switch self {
        case .wasNot:
            return "☹️"
        case .neutre:
            return "🤔"
        case .very:
            return "😌"
        case .aLot:
            return "😍"
        default:
            return ""
        }
        
    }
}

struct LearningDetailsView: View {
    @ObservedObject var learning: Learning
    
    var color: Color
    var delegate: LearningDelegate?
    
    var body: some View {
        VStack {
            HStack {
                //                if let detail = learning.detail{
                //                    Text(detail)
                //                }
                //                Button(action:{
                //                    learning.setDetails(detail: "Foi muito trabalhoso desviar de tubarões, mas ao mesmo tempo é divertido fazer eles de besta. Não morri.", humor: 3, steps: ["Vestir a roupa de mergulho","Entrar no mar de piedade","Cortar a ponta do dedo pra sair sangue", "Nadar em círculos", "Se um tubarão aparecer, bater no focinho!"])
                //                    learning.objectWillChange.send()
                //                }){
                //                    Text("Pressssssssssss")
                //                }
                Text(learning.emoji ?? "?")
                    .font(.system(size: 60))
                    .padding(11)
                    .overlay(Circle().stroke(color, lineWidth: 2))
                    .padding(.leading, 30)
                
                VStack(alignment:.leading) {
                    Text(learning.name ?? "Name")
                        .font(.largeTitle.bold())
                    
                    Text(learning.descriptionText ?? "Description")
                }.padding(.leading, 20)
                
                Spacer()
                
                Button(action: {
                    learning.toggleIsFixed()
                    delegate?.resetFixedLearnings()
                }) {
                    Text(Image(systemName: learning.isFixed ? "pin.fill" : "pin"))
                        .font(.system(size: 28))
                        .foregroundColor(color)
                        .rotationEffect(.init(degrees: 45))
                        .padding()
                }
                
                
            }.padding(.bottom, 20)
            .padding(.top)
            
            Divider()
            
            VStack{
                Text("Nessa atividade, aprendi que")
                    .bold()
                    .padding(.bottom)
                Text(learning.detail ?? "")
                
            }
            .padding()
            
            HStack(alignment: .top){
                
                VStack{
                    
                    Text("As etapas para realizá-la foram")
                        .bold()
                        .padding(.bottom)
                    
                    ScrollView{
                        VStack(alignment: .leading){
                            let steps = learning.steps ?? []
                            ForEach(0..<(steps).count, id: \.self){ index in
                                HStack{
                                    Rectangle()
                                        .fill(color)
                                        .frame(width: 19, height: 19)
                                    
                                    Text(steps[index])
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    
                }
                
                VStack{
                    Text("Para mim, essa atividade foi")
                        .bold()
                        .padding(.bottom)
                    let humorIndex = Int(truncating: learning.humor ?? 4)
                    let humor = Humor(rawValue: humorIndex)
                    Text(humor!.emoji)
                    Text(humor!.text)
                    Text("agradável")
                }
            }
            
            Spacer()
            
        } .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Editar") {
                    print("Estamos editando")
                }
            }
        }
        
    }
}

struct LearningDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmptyView()
            LearningDetailsView(learning: Learning(name: "Sushii", descriptionText: "Pança cheiaaa de Beatrix Lee", emoji: "🍣", estimatedTime: 1800, text: "Sei lá", context: AppDelegate.viewContext), color: .blue)
        }
    }
}
