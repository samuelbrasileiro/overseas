//
//  TweetTextView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 28/07/21.
//

import Foundation
import SwiftUI

struct TweetTextView: View{
    var color: Color
    var height, width: CGFloat
    
    init(c: Color, h:CGFloat, w:CGFloat){
        self.color = c
        self.height = h
        self.width = w
    }
    var body: some View {
        ZStack{
            Rectangle()
                .frame(height: height)
                .padding(.top, 14)
                .foregroundColor(color)

                
            Rectangle()
                .strokeBorder(color, lineWidth: 2)
                .background(Rectangle().fill(Color(.white)))
                .frame(height: height)
                .padding(.trailing, 14)
        }
        .padding(.horizontal, 80)
    }
}


struct TweetTextView_Previews: PreviewProvider {
    static var previews: some View {
        TweetTextView(c: Color(.systemPink), h: 302, w: 921)
    }
}
