//
//  OnboardingMappingCategoryView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 19/07/21.
//

import SwiftUI

struct SelectionCategory{
    var isSelected: Bool = false
    var name: String
    var emoji: String
}

struct OnboardingMappingCategoryView: View {
    @Binding var category: SelectionCategory
    @State var color: Color = .lightBlue
    
    @State var isPresented = false
    
    var body: some View {
        Button(action:{
            self.category.isSelected.toggle()
            if category.isSelected{
                self.color = .darkBlue
            }
            else{
                self.color = .lightBlue
            }
        }){
            ZStack{
                VStack(alignment: .leading){
                    ZStack(alignment: .trailing){
                        Rectangle()
                            .fill(color)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                            .foregroundColor(.white)
                            .padding(10)
                            .opacity(self.category.isSelected ? 1 : 0)
                        
                        
                    }
                    .frame(height: 40)
                    Text(category.emoji)
                        .font(.system(size: 60))
                        .padding(11)
                        .overlay(Circle().stroke(color, lineWidth: 2))
                        .padding(.leading)
                    
                    Text(category.name)
                        .font(.title.bold())
                        .foregroundColor(.black)
                        .padding(.leading)
                        
                    
                    Spacer()
                    
                    
                    
                }
                Rectangle().stroke(color, lineWidth: 4)
                
            }
        }
        .frame(maxWidth: 300, maxHeight: 300)
        
    }
}

//struct OnboardingMappingCategoryView_Previews: PreviewProvider {
////    @State var c = SelectionCategory(name: "Culinária", emoji: "🍣")
////    static var previews: some View {
////        OnboardingMappingCategoryView(category: $c)
////            
////            .previewLayout(.fixed(width: 300, height: 300))
////            .environment(\.horizontalSizeClass, .compact)
////            .environment(\.verticalSizeClass, .compact)
////    }
//}
