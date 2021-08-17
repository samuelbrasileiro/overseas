//
//  OnboardingView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct OrganizingOnboardingView: View {
    
    @State var scale = CGSize(width: 1, height: 1)
    @State var positions = [CGPoint(x: -6,y: -60), CGPoint(x: -7,y: 70), CGPoint(x: -5,y: 81), CGPoint(x: -4,y: 80)]
    var finalPositions = [CGPoint(x: 1.75,y: -20), CGPoint(x: 2,y: -25), CGPoint(x: 1.75,y: -20), CGPoint(x: 1.5,y: -15)]
    
    var body: some View {
        
        VStack {
            
            
            
            ZStack{
                
                Image("BackFolder")
                    .offset(x: UIScreen.main.bounds.width/1.5 , y: 0)
                    .scaleEffect(CGSize(width: 0.35, height: 0.35))
                
                
                OnboardingCardView(position: $positions[0], scale: $scale, emoji: "🥦", color: .green)
                OnboardingCardView(position: $positions[1], scale: $scale, emoji: "🤡", color: .red)
                OnboardingCardView(position: $positions[2], scale: $scale, emoji: "🤝", color: .blue)
                OnboardingCardView(position: $positions[3], scale: $scale, emoji: "🧚🏼‍♂️", color: .purple)
                
                Image("FrontFolder")
                    .offset(x: UIScreen.main.bounds.width/1.5, y: 0)
                    .scaleEffect(CGSize(width: 0.35, height: 0.35))
                
            }
            .padding(.top, 100)
            
            
            Text("Tudo em seu devido lugar")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Organize seus aprendizados em um espaço construído por você.")
                .padding(.bottom)
            
        }
        
        .onAppear {
            withAnimation(.spring().speed(0.5).delay(2)) {
                positions = finalPositions
                scale = CGSize(width: 0.4, height: 0.4)
            }
        }
    }
}
