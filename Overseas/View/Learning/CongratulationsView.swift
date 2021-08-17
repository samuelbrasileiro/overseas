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
    
    @State var offset: CGSize = CGSize(width: -250, height: 100)
    @State var ammount = 0
//    @ObservedObject var nav: BindingNav
//    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            ZStack{
                Image("Target")
                   
                    .modifier(Shake(animatableData: CGFloat(ammount)))

                    .onAppear(){
                        withAnimation(.default.delay(0.35)){
                            ammount += 1
                        }
                    }
                
                Image("Arrow")
                    .offset(offset)
                    .onAppear(){
                        offset = CGSize(width: -130, height: 50)
                    }
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
//                isPresented = false
//                nav.isPresented = false
                print("clicou dismiss congrats")
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
    }
}

//struct CongratulationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CongratulationsView(nav: BindingNav(), isPresented: true)
//    }
//}
