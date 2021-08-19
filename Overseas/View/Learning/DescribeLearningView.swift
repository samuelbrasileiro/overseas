//
//  DescribeLearningView.swift
//  Overseas
//
//  Created by Beatrix lee on 28/07/21.
//

import SwiftUI
import Combine

//extension Notification {
//    var keyboardHeight: CGFloat {
//        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
//    }
//}

extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<Bool, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map {  _ in Bool()}

        return AnyPublisher(willShow)
    }
}

struct DescribeLearningView: View {
    
    var color: Color
    @State var keyboardOpen: Bool = false
    var learning: Learning

    @ObservedObject var env: RegisterEnvironment
    
    var body: some View {
        VStack(alignment: .leading) {
            TweetTextView(color: color, maxHeight: 47){
                Text("O que você aprendeu nessa atividade?")
                    .padding(.leading, 15)
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 100)
            
            
            TweetTextView(color: color, maxHeight: 302, alignment: .leading){
                TextEditor(text: $env.description)
                    .frame(maxHeight: 290)
                    .padding(.top)
                    .padding([.leading, .bottom,.trailing], 10)
                    
                
            }
            .padding(.horizontal, 35)
//            .onReceive(Publishers.keyboardHeight, perform: {self.keyboardOpen =  $0})
//            .offset(y: keyboardOpen ? -100 : 0)

                    .onAppear{
                        if learning.detail != nil {
                            env.description = learning.detail!
                        }
                        
                    }
                    .padding(.horizontal, 35)
                
            }
        }

    }
}

//struct DescribeLearningView_Previews: PreviewProvider {
//    static var previews: some View {
//        DescribeLearningView(color: .green, env: RegisterEnvironment())
//            .previewLayout(.fixed(width: 1080, height: 810))
//            .environment(\.horizontalSizeClass, .compact)
//            .environment(\.verticalSizeClass, .compact)
//    }
//}
