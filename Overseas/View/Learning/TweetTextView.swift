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
    var maxHeight: CGFloat = .infinity
    var maxWidth: CGFloat = .infinity
    var alignment: Alignment = .leading
    
    var content: () -> Content
    
    
    var body: some View {
        ZStack(alignment: alignment){
            ZStack{
                Rectangle()
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                    .foregroundColor(color)
                    .offset(x: 10, y: 10)
                
                Rectangle()
                    .strokeBorder(color, lineWidth: 2)
                    .background(Rectangle().fill(Color(.white)))
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            }
            content()
                .padding(.leading, 15)
        }
        .padding(.horizontal, 80)
    }
}


struct TweetTextView_Previews: PreviewProvider {
    static var previews: some View {
        TweetTextView(color: Color(.systemPink), maxHeight: 302){EmptyView()}
    }
}
