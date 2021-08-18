//
//  CongratulationsView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 02/08/21.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 5
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct CongratulationsView: View {
    
    var defaultOffset: CGSize = CGSize(width: -250, height: 100)
    var finalOffset: CGSize = CGSize(width: -130, height: 50)
    @Binding var ammount: Int
    @Environment(\.presentationMode) var presentationMode
    @Binding var showCongrats: Bool
    
    var body: some View {
        VStack{
            ZStack{
                Image("Target")
                    .modifier(Shake(animatableData: CGFloat(ammount)))
                    
                Image("Arrow")
                    .offset(showCongrats ? finalOffset : defaultOffset)
                    .animation(.easeIn)
                
            }
            .padding(.bottom, 50)

            
            Text("Parabéns!")
                .font(.title)
                .padding(.bottom,5)

            
            Text("Você conseguiu alcançar mais uma etapa de aprendizado")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            Button {
                presentationMode.wrappedValue.dismiss()
                print("clicou dismiss congrats")
                print(showCongrats)
            } label: {
                ZStack{

                    Rectangle()
                        .foregroundColor(Color(.systemBlue))
                        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/15, alignment: .center)
                    Text("Concluir aprendizado")
                        .font(.title2)
                        .foregroundColor(Color(.systemBackground))
                }
            }
        }
        .padding(.all, 50)
        .background(Color(.systemBackground).shadow(radius: 7))
    }
}
