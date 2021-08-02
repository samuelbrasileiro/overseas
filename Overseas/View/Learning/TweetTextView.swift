//
//  TweetTextView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 28/07/21.
//

import Foundation
import SwiftUI

struct TweetTextView<Content>: View where Content: View {
    var color: Color
    var height: CGFloat
    var alignment: Alignment = .leading
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: alignment){
            ZStack{
                Rectangle()
                    .frame(height: height)
                    .foregroundColor(color)
                    .offset(x: 10, y: 10)
                
                Rectangle()
                    .strokeBorder(color, lineWidth: 2)
                    .background(Rectangle().fill(Color(.white)))
                    .frame(height: height)
            }
            content()
                .padding(.leading, 15)
        }
        .padding(.horizontal, 80)
    }
}


struct TweetTextView_Previews: PreviewProvider {
    static var previews: some View {
        TweetTextView(color: Color(.systemPink), height: 302){EmptyView()}
    }
}
