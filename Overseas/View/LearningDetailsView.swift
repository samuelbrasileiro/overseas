//
//  LearningDetailsView.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 27/07/21.
//

import SwiftUI

struct LearningDetailsView: View {
    @ObservedObject var learning: Learning
    var color: Color
    
    var body: some View {
        VStack{
            HStack{
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
            }
        } .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LearningDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LearningDetailsView(learning: Learning(name: "Sushii", descriptionText: "Pança cheiaaa de Beatrix Lee", emoji: "🍣", estimatedTime: 1800, text: "Sei lá", context: AppDelegate.viewContext), color: .blue)
    }
}
