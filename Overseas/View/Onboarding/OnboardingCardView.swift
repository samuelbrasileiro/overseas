//
//  OnboardingCardView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 03/08/21.
//

import SwiftUI

struct OnboardingCardView: View {
    
    @State var isPresented = false
    @Binding var position: CGPoint
    @Binding var scale: CGSize
    @State var emoji: String
    @State var color: Color
    
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading){
                ZStack(alignment: .trailing){
                    Rectangle()
                        .fill(color)
                    
                }
                .frame(height: 40)
                
                Text(emoji)
                    .font(.system(size: 60))
                    .padding(11)
                    .overlay(Circle().stroke(color, lineWidth: 2))
                    .padding(.leading)
                
                
                Spacer()
                
            }
            Rectangle().stroke(color, lineWidth: 4)
            
        }
        .background(Color.white)
        .frame(maxWidth: 250, maxHeight: 250)
        .offset(x: position.x, y: position.y)
        .scaleEffect(scale)
    }
}

//struct OnboardingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingCardView()
//    }
//}
