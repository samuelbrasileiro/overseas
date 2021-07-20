//
//  OnboardingView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
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

struct OnboardingView: View {
    
    @State var scale = CGSize(width: 1, height: 1)
    @State var positions = [CGPoint(x: -80,y: 20), CGPoint(x: -100,y: 70), CGPoint(x: -300,y: 0), CGPoint(x: -200,y: 80)]
    var finalPositions = [CGPoint(x: 440,y: 0), CGPoint(x: 480,y: -30), CGPoint(x: 460,y: 0), CGPoint(x: 520,y: -10)]
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            ZStack{
                
                Image("BackFolder")
                    .offset(x: 200, y: 0)
                
                
                OnboardingCardView(position: $positions[0], scale: $scale, emoji: "🥦", color: .green)
                OnboardingCardView(position: $positions[1], scale: $scale, emoji: "🤡", color: .red)
                OnboardingCardView(position: $positions[2], scale: $scale, emoji: "🤝", color: .blue)
                OnboardingCardView(position: $positions[3], scale: $scale, emoji: "🧚🏼‍♂️", color: .purple)
                
                Image("FrontFolder")
                    .offset(x: 200, y: 0)
                
            }
            .padding(.top, 100)
            
            
        
            
            Text("Tudo em seu devido lugar")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 150)
            
            Text("Organize seus aprendizados em um espaço construído por você.")
            
            Spacer()
        }
        
        .onAppear {
            withAnimation(.spring().speed(0.5).delay(2)) {
                positions = finalPositions
                scale = CGSize(width: 0.4, height: 0.4)
            }
        }
    }
}

struct BrainOnboardingView: View {
    var body: some View {
        Text("Oi")
    }
}

struct PageViewController: View {
    var body: some View {
        
        TabView {
            OnboardingView()
            BrainOnboardingView()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
 
    }
}




struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController()
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
