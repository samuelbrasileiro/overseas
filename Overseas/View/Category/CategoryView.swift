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
    @State var colorIndex: Int = 0
    @State var name: String = ""

    
    @State var isEditMode: EditMode = .inactive{
        didSet{
            print(isEditMode)
            print(name)
        }
    }
    
    var body: some View {
        let learnings = homeEnv.getLearningsFromCategory(index)
        
        VStack{
            HStack{
                if(isEditMode == .active){
                    VStack{
                        HStack{
                            TextField("", text: $name)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.largeTitle.bold())
                                .onAppear{
                                    name = homeEnv.categories[index].name ?? "Categoria"
                                }
                            Spacer()
                            
                            Image(systemName: "multiply")
                                .foregroundColor(Color(.systemGray))
                                .frame(width:30,height:30)
                                .background(
                                    Rectangle().fill(Color(.systemGray6))

                                )
                                .onTapGesture {
                                    name = ""
                                }
                        }
                      
                        Divider()
                         .frame(height: 2)
                         .padding(.horizontal, 30)
                            .background(Color.black)
                    }
                        

                }else{
                    Text(homeEnv.categories[index].name ?? "Categoria").underline()
                        .font(.largeTitle.bold())
                       
                }
                

                

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
                        .opacity(isEditMode == .active ? 0 : 1)
                        .animation(nil)
                }
                .accentColor(.primary)
                
                Spacer()
                
                ForEach((0..<Color.categoryColors.count)){index in
                    Button(action:{
                        self.colorIndex = index
                        
                    }){
                        ZStack{
                            Circle()
                                .fill(Color.categoryColors[index])
                                .frame(width: 40, height: 40)
                                .padding(4)
                                .overlay(Circle().stroke().foregroundColor(Color.categoryColors[index]).opacity(index == colorIndex ? 1 : 0)
                                )
                            Text(Image(systemName: "checkmark"))
                                .foregroundColor(Color(.systemBackground))
                                .font(.system(size: 10))
                                .opacity(index == colorIndex ? 1 : 0)
                        }
                        .opacity(isEditMode == .active ? 1 : 0)
                        .padding(.trailing)
                    }
                    .onAppear{
                        colorIndex = homeEnv.categories[self.index].colorIndex
                            
                    }
                }
            }
            .padding(.leading)
            .padding([.leading, .top], 40)
            .padding(.top, 40)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(),GridItem()], content: {
                    ForEach(0..<learnings.count, id: \.self){ i in
                        ZStack(alignment: .topTrailing){
                            
                            CategoryLearningView(learning: learnings[i], color: Color.categoryColors[self.colorIndex], delegate: homeEnv)
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
                                    .foregroundColor(Color.categoryColors[self.colorIndex])
                                    .frame(width:50,height:50)
                                    .background(Rectangle().stroke().foregroundColor(Color.categoryColors[self.colorIndex]).background(Rectangle().fill(Color(.white))))
                                    .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: -10)
                                    
                            }
                            .opacity(isEditMode == .active ? 1 : 0)
                            .animation(nil)
                        }    .padding()
                        
                    }
                    //.rotationEffect(Angle(radians: isEditMode == .active ? 0.06 : 0))
                        
                    //.animation(.default.speed(3).repeat(while: isEditMode == .active, autoreverses: true))
                    
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
                    Button(action:{
                        if isEditMode == .active{
                            isEditMode = .inactive
                            homeEnv.updateCategory(categoryIndex: index, name: name, index: colorIndex)

                        }
                        else{
                            isEditMode = .active
                        }
                    }){
                    EditButton()
                       
                    }
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
