//
//  HomeScreenLearningItemView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct HomeScreenLearningItemView: View {
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
                    
                
                
                Text(String(Int(learning.estimatedTime / 60)) + " minutos" )
                    .padding(.leading)
                    .padding(.bottom, 20)
            }
            Rectangle().stroke(color, lineWidth: 4)
            
        }
        .frame(maxWidth: 300, maxHeight: 300)
    }
}

struct HomeScreenLearningItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenLearningItemView(learning: Learning(name: "Sushii", descriptionText: "Pança cheiaaa de Beatrix Lee", emoji: "🍣", estimatedTime: 1800, text: "Sei lá", context: AppDelegate.viewContext), color: .blue)
            .previewLayout(.fixed(width: 300, height: 300))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
