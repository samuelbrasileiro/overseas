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
        ZStack{
            Rectangle()
                .foregroundColor(color)
                .offset(x: 10, y: 10)
            ZStack(alignment: alignment){
                
                Rectangle()
                    .strokeBorder(color, lineWidth: 2)
                    .background(Rectangle().fill(Color(.systemBackground)))
                    
                content()
                    //.padding(.leading, 15)
                    .padding(.top, 5)
            }
            
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        //.padding(.horizontal, 30)
        
    }
}


struct TweetTextView_Previews: PreviewProvider {
    static var previews: some View {
        TweetTextView(color: Color(.systemPink), maxHeight: 302){EmptyView()}
    }
}
