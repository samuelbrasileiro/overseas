//
//  CategoryView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI

struct CategoryView: View {
    @State var index: Int
    @ObservedObject var homeEnv: HomeScreenEnvironment
    
    @State var isPresented = false
    
    @State var isEditMode: EditMode = .inactive{
        didSet{
            print(isEditMode)
        }
    }
    
    var body: some View {
        var learnings = homeEnv.getLearningsFromCategory(index)
        
        VStack{
            HStack{
                Text(homeEnv.categories[index].name ?? "Categoria").underline()
                    .font(.largeTitle.bold())
                Button(action: {
                    homeEnv.lastCategory = index
                    homeEnv.didSelectNewLearning = true
                }){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                        .padding(10)
                        .overlay(Rectangle().stroke(Color.primary, lineWidth: 2))
                        .padding(.leading)
                }
                .accentColor(.primary)
                
                Spacer()
            }
            .padding(.leading)
            .padding([.leading, .top], 40)
            .padding(.top, 40)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(),GridItem()], content: {
                    ForEach(0..<learnings.count, id: \.self){ i in
                        ZStack(alignment: .topTrailing){
                            
                            CategoryLearningView(learning: learnings[i], color: Color.categoryColors[homeEnv.categories[index].colorIndex], delegate: homeEnv)
                                .animation(nil)
                            Button(action: {
                                withAnimation { () -> () in
                                    //learnings.remove(at: i)
                                    let context = AppDelegate.viewContext
                                    context.delete(learnings[i])
                                    do{
                                        try context.save()
                                    }catch{
                                        print(error)
                                    }
                                    homeEnv.objectWillChange.send()
                                }
                            }){
                                Text(Image(systemName: "multiply"))
                                    .bold()
                                    .foregroundColor(Color(.systemBackground))
                                    .frame(width:40,height:40)
                                    .background(Color.primary)
                                    
                            }
                            .opacity(isEditMode == .active ? 1 : 0)
                            .animation(nil)
                        }    .padding()
                        
                    }
                    .rotationEffect(Angle(radians: isEditMode == .active ? 0.06 : 0))
                    .animation(.default.speed(3).repeat(while: isEditMode == .active, autoreverses: true))
                    
                })
                .padding(.top)
                .padding(.trailing, 40)
            }
            .padding(.leading, 40)
            Spacer()
        }
        
        .navigationBarHidden(false)
        .navigationTitle(homeEnv.categories[index].name ?? "")
        .background(NavigationConfigurator { nc in
            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.clear]
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
        }
        .environment(\.editMode, self.$isEditMode)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(index: 0, homeEnv: HomeScreenEnvironment())
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
