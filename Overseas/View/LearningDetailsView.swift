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
    
    var text: LocalizedStringKey{
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
    
    @ObservedObject var detailNav = BindingNav()
    @ObservedObject var registerNav = BindingNav()
    
    var color: Color
    var delegate: LearningDelegate?
    
    var body: some View {
        VStack {
            HStack {
                
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
                    Text(Image(systemName: learning.isFixed ? "heart.fill" : "heart"))
                        .font(.system(size: 28))
                        .foregroundColor(color)
                        .padding()
                }
                
                
            }.padding(.bottom, 20)
            .padding(.top)
            
            Divider()
            
            TweetTextView(color: color, maxHeight: 150, alignment: .leading){
                VStack(alignment: .leading){
                    Text("Nessa atividade, aprendi que")
                        .bold()
                        .padding(.vertical)
                    
                    
                    
                    Text(learning.detail ?? "")
                    
                    Spacer()
                }
                .padding(.leading, 15)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 30)
            
            HStack(alignment: .top){
                
                TweetTextView(color: color){
                    VStack(alignment: .leading){
                        
                        Text("As etapas para realizá-la foram")
                            .bold()
                            .padding(.vertical)
                            .padding(.leading, 15)
                        
                        
                        
                        ScrollView{
                            VStack(alignment: .leading){
                                let steps = learning.steps ?? []
                                ForEach(0..<(steps).count, id: \.self){ index in
                                    HStack{
                                        Rectangle()
                                            .fill(color)
                                            .frame(width: 19, height: 19)
                                        
                                        Text(steps[index])
                                        Spacer()
                                    }
                                    .padding(.leading, 15)
                                    
                                }
                            }
                        }
                        
                        
                    }
                }
                .padding(.horizontal, 30)
                
                TweetTextView(color: color, maxWidth: 200){
                    VStack{
                        HStack {
                            Spacer()
                            Text("Para mim, essa atividade foi")
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.vertical)
                            Spacer()
                        }
                        
                        
                        let humorIndex = Int(truncating: learning.humor ?? 4)
                        let humor = Humor(rawValue: humorIndex)
                        Text(humor!.emoji)
                            .font(Font.system(size:70, design: .default))
                            .padding(.bottom, 5)
                        
                        Text(humor!.text)
                        Text("agradável")
                        Spacer()
                    }
                }
                
            }
            .padding(.trailing, 30)
            
            .padding(.bottom)
            Spacer()
            
        } .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                
                NavigationLink(destination: RegisterLearningView(color: color, learning: learning, nav: registerNav), isActive: $registerNav.isPresented){
                    Text("Editar")
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
