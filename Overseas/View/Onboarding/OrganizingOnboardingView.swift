//
//  OnboardingView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct OrganizingOnboardingView: View {
    
    @State var scale = CGSize(width: 1, height: 1)
    @State var positions = [CGPoint(x: -80,y: 20), CGPoint(x: -100,y: 70), CGPoint(x: -300,y: 0), CGPoint(x: -200,y: 80)]
    var finalPositions = [CGPoint(x: 440,y: 0), CGPoint(x: 480,y: -30), CGPoint(x: 460,y: 0), CGPoint(x: 520,y: -10)]
    
    var body: some View {
        
        VStack {
            
            
            
            ZStack{
                
                Image("BackFolder")
                    .offset(x: 600, y: 0)
                    .scaleEffect(CGSize(width: 0.35, height: 0.35))
                
                
                OnboardingCardView(position: $positions[0], scale: $scale, emoji: "🥦", color: .green)
                OnboardingCardView(position: $positions[1], scale: $scale, emoji: "🤡", color: .red)
                OnboardingCardView(position: $positions[2], scale: $scale, emoji: "🤝", color: .blue)
                OnboardingCardView(position: $positions[3], scale: $scale, emoji: "🧚🏼‍♂️", color: .purple)
                
                Image("FrontFolder")
                    .offset(x: 600, y: 0)
                    .scaleEffect(CGSize(width: 0.35, height: 0.35))
                
            }
            .padding(.top, 100)
            
            
            Text("Tudo em seu devido lugar")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Organize seus aprendizados em um espaço construído por você.")
            
            
        }
        
        .onAppear {
            withAnimation(.spring().speed(0.5).delay(2)) {
                positions = finalPositions
                scale = CGSize(width: 0.4, height: 0.4)
            }
        }
    }
}
