//
//  KnowledgeOnboardingView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 03/08/21.
//

import SwiftUI


struct KnowledgeOnboardingView: View {
    
    var delegate: OnboardingDelegate?
    @ObservedObject var env = OnboardingEnvironment()
    @State var isPresented = false
    @State var scaleBrain = CGSize(width: 0.25, height: 0.25)
    @State var scaleObjects = CGSize(width: 0.25, height: 0.25)
    @State var initialPositions = [CGPoint(x: 1, y: -1000), CGPoint(x: -1225, y: 125), CGPoint(x: 1500, y: 125), CGPoint(x: 125, y: 125)]
    @State var finalPositions = [CGPoint(x: 125, y: 125), CGPoint(x: 125, y: 125), CGPoint(x: 125, y: 125), CGPoint(x: 125, y: 125)]
    
    var body: some View {
        VStack {
            
            ZStack {
                    
                Image("Camping")
                    .offset(x: UIScreen.main.bounds.width/3, y: UIScreen.main.bounds.height * 0.15)
                    .position(initialPositions[0])
                    .scaleEffect(scaleObjects)

                
                Image("Tricot")
                    .offset(x: UIScreen.main.bounds.width/3, y: UIScreen.main.bounds.height * 0.15)
                    .position(initialPositions[1])
                    .scaleEffect(scaleObjects)
                
                Image("Surfboard")
                    .offset(x: UIScreen.main.bounds.width/3, y: UIScreen.main.bounds.height * 0.15)
                    .position(initialPositions[2])
                    .scaleEffect(scaleObjects)
                
                Image("Brain")
//                    .offset(x: UIScreen.main.bounds.width/3, y: UIScreen.main.bounds.height * 0.15)
                    .scaleEffect(scaleBrain)
                    .position(initialPositions[3])
                
                
            }
            .frame(maxWidth: 250, maxHeight: 250)
            
            .padding(.top, 150)
            .padding(.bottom, 50)
            
            Text("Conhecimento para além do óbvio")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 100)
            
            Text("Valorize seus aprendizados do cotidiano.")
            
            Button(action:{
                isPresented = true
            }){
                HStack{
                    Spacer()
                Text("Mapear interesses")
                    .font(.title)
                    .foregroundColor(Color(.systemBackground))
                    .padding()
                    Spacer()
                }
                .background(Color.darkBlue)
                .overlay(Rectangle().stroke(Color.darkBlue, lineWidth: 2))
                .padding(.all, 40)
                
            }

        }
        .onAppear(){
            withAnimation(.linear(duration: 1).delay(2)){
                initialPositions = finalPositions
                scaleBrain = CGSize(width: 0.5, height: 0.5)
                scaleObjects = CGSize(width: 0.125, height: 0.125)
            }
            
        }
        .fullScreenCover(isPresented: $isPresented){
            OnboardingMappingView(delegate: delegate, env: OnboardingEnvironment())
        }
    }
}

struct KnowledgeOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        KnowledgeOnboardingView()
    }
}
