//
//  CategoryLearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CategoryLearningView: View {
    @ObservedObject var learning: Learning
    var color: Color //lembrar de fazer referencia à color do category referente (não fizemos porque é string)
    
    @State var isPresented = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ZStack(alignment: .trailing){
                    Rectangle()
                        .fill(color)
                    Circle()
                        .frame(width:30)
                        .foregroundColor(.white)
                        .padding(10)
                }
                .frame(height: 40)
                ZStack(alignment: .topTrailing){
                    HStack{
                        VStack(alignment: .leading){
                            Text(learning.emoji ?? "?")
                                .font(.system(size: 60))
                                .padding(11)
                                .overlay(Circle().stroke(color, lineWidth: 2))
                                .padding(.leading)
                            
                            Text(learning.name ?? "Name")
                                .font(.largeTitle.bold())
                                .padding(.leading)
                            Text(learning.descriptionText ?? "Description")
                                
                                .padding(.leading)
                            Spacer()
                            
                            
                            
                            Text(String(Int(learning.estimatedTime / 60)) + " minutos • \(learning.dateFormatter.string(from: learning.creationDate!))" )
                                .padding(.leading)
                                .padding(.bottom, 20)
                        }
                        .padding([.leading,.top])
                        Spacer()
                    }
                    
                    Text(Image(systemName: "pin.fill"))
                        .font(.system(size: 28))
                        .foregroundColor(color)
                        .rotationEffect(.init(degrees: 45))
                        .padding()
                        .opacity(learning.isFixed ? 1 : 0)
                        
                }
            }
            Rectangle().stroke(color, lineWidth: 4)
            
        }
        .navigationBarHidden(false)
    }
}

struct CategoryLearningView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLearningView(learning: Learning(name: "Sushii", descriptionText: "Pança cheiaaa de Beatrix Lee", emoji: "🍣", estimatedTime: 1800, text: "Sei lá", context: AppDelegate.viewContext), color: .blue)
                                .previewLayout(.fixed(width: 600, height: 300))
                                .environment(\.horizontalSizeClass, .compact)
                                .environment(\.verticalSizeClass, .compact)
    }
}
