//
//  CategoryLearningView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CategoryLearningView: View {
    @ObservedObject var learning: Learning
    var color: Color //lembrar de fazer referencia à color do category referente (não fizemos porque é string)
    
    @ObservedObject var detailNav = BindingNav()
    @ObservedObject var registerNav = BindingNav()
    var delegate: LearningDelegate?
    
    var body: some View {
        

        Button(action:{
            if learning.detail != nil && learning.detail != ""{
                detailNav.isPresented = true
            }
            else{
                registerNav.isPresented = true
            }
        }){
            
            ZStack{
                NavigationLink(destination: LearningDetailsView(learning: learning, color: color, delegate: delegate), isActive: $detailNav.isPresented){
                    EmptyView()
                }
                NavigationLink(destination: RegisterLearningView(color: color, learning: learning, nav: registerNav), isActive: $registerNav.isPresented){
                    EmptyView()
                }
                
                VStack(alignment: .leading){
                    ZStack(alignment: .trailing){
                        Rectangle()
                            .fill(color)
                        Circle()
                            .fill(Color(.systemBackground))
                            .frame(width:30)
                            .padding(10)
                    }
                    .frame(height: 40)
                    ZStack(alignment: .topTrailing){
                        HStack{
                            VStack(alignment: .leading){
                                Text(learning.emoji ?? "?")
                                    .font(.system(size: 60))
                                    .padding(11)
                                    .overlay(Circle().stroke(color, lineWidth: 2))
                                    .padding(.leading)
                                
                                Text(learning.name ?? "Name")
                                    .font(.largeTitle.bold())
                                    .padding(.leading)
                                Text(learning.descriptionText ?? "Description")
                                    
                                    .padding(.leading)
                                Spacer()
                                
                                
                                
                                Text("\(learning.dateFormatter.string(from: learning.creationDate!))" )
                                    .padding(.leading)
                                    .padding(.bottom, 20)
                            }
                            .padding([.leading,.top])
                            Spacer()
                        }
                        
                        Text(Image(systemName: "heart.fill"))
                            .font(.system(size: 28))
                            .foregroundColor(color)
                            .padding()
                            .opacity(learning.isFixed ? 1 : 0)
                        
                    }
                }
                Rectangle().stroke(color, lineWidth: 4)
                
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(false)
            
            
            
        }.accentColor(.primary)
        .onDrag {
            let learningViewImage = CategoryLearningView(learning: learning, color: color).frame(width: 500, height: 400).background(Color(.systemBackground).shadow(radius: 7)).padding(30).snapshot()
            
            let provider = NSItemProvider(object: learningViewImage)
            provider.suggestedName = learning.name ?? "Aprendizado"
            //provider.preferredPresentationSize
            
            return provider
        }
    }
    
}

struct CategoryLearningView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLearningView(learning: Learning(name: "Sushii", descriptionText: "Pança cheiaaa de Beatrix Lee", emoji: "🍣", estimatedTime: 1800, text: "Sei lá", context: AppDelegate.viewContext), color: .blue)
            .previewLayout(.fixed(width: 600, height: 300))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
