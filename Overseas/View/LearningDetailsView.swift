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

struct LearningDetailsView: View {
    @ObservedObject var learning: Learning
    
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
                    Text(Image(systemName: learning.isFixed ? "pin.fill" : "pin"))
                        .font(.system(size: 28))
                        .foregroundColor(color)
                        .rotationEffect(.init(degrees: 45))
                        .padding()
                }

               
            }.padding(.bottom, 20)
            .padding(.top)
            
            Divider()
            
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
