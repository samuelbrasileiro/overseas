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

struct OrganizingOnboardingView: View {
    
    @State var scale = CGSize(width: 1, height: 1)
    @State var positions = [CGPoint(x: -80,y: 20), CGPoint(x: -100,y: 70), CGPoint(x: -300,y: 0), CGPoint(x: -200,y: 80)]
    var finalPositions = [CGPoint(x: 440,y: 0), CGPoint(x: 480,y: -30), CGPoint(x: 460,y: 0), CGPoint(x: 520,y: -10)]
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
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

struct KnowledgeOnboardingView: View {
    
    @ObservedObject var env = OnboardingEnvironment()
    @State var isPresented = false
    
    @State var scaleBrain = CGSize(width: 0.25, height: 0.25)
    @State var scaleObjects = CGSize(width: 0.25, height: 0.25)
    @State var initialPositions = [CGPoint(x: 125, y: -1250), CGPoint(x: -1225, y: 125), CGPoint(x: 1500, y: 125), CGPoint(x: 125, y: 125)]
    @State var finalPositions = [CGPoint(x: 125, y: 125), CGPoint(x: 125, y: 125), CGPoint(x: 125, y: 125), CGPoint(x: 125, y: 125)]
    
    var body: some View {
        VStack {
            
            ZStack {
                
                Image("Camping")
                    .position(initialPositions[0])
                    .scaleEffect(scaleObjects)
                
                Image("Tricot")
                    .position(initialPositions[1])
                    .scaleEffect(scaleObjects)
                
                Image("Surfboard")
                    .position(initialPositions[2])
                    .scaleEffect(scaleObjects)
                
                Image("Brain")
                    .scaleEffect(scaleBrain)
                    .position(initialPositions[3])
                
                
            }
            .frame(maxWidth: 250, maxHeight: 250)
            .padding(.top, 250)
            .padding(.bottom, 50)
            
            Text("Conhecimento para além do óbvio")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 150)
            
            Text("Valorize seus aprendizados do cotidiano.")
            
            Button(action:{
                isPresented = true
            }){
                HStack{
                    Spacer()
                Text("Mapear interesses")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
                }
                .background(Color.darkBlue)
                .overlay(Rectangle().stroke(Color.darkBlue, lineWidth: 2))
                .padding(.horizontal, 40)
                .padding(.top, 50)
            }

        }
        .onAppear(){
            withAnimation(.spring().speed(0.5).delay(2)){
                initialPositions = finalPositions
                scaleBrain = CGSize(width: 0.5, height: 0.5)
                scaleObjects = CGSize(width: 0.125, height: 0.125)
            }
        }
        .fullScreenCover(isPresented: $isPresented){
            OnboardingMappingView(env: OnboardingEnvironment())
        }
    }
}

struct PageViewController: View {
    var body: some View {
        
        TabView {
            OrganizingOnboardingView()
            KnowledgeOnboardingView()
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
