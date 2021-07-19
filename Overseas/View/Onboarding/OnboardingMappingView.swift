//
//  OnboardingMappingView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI
import CoreData
class OnboardingEnvironment: ObservableObject{
    @Published var categories: [SelectionCategory] = []
    
    init(){
        categories.append(contentsOf: [("Culinária","🧑‍🍳"), ("Investimento","💸"), ("Música","🎵"), ("Manutenção da casa","🔧"), ("Videogames","🎮"), ("Cabelo","💈"), ("Animais de estimação","🐶"), ("Skin Care","🧼") ].map{.init(name: $0.0, emoji: $0.1)})
    }
    
    func saveSelectedToCoreData(){
        let context = AppDelegate.viewContext
        
        _ = self.categories.filter({$0.isSelected}).map{Category(name: $0.name, color: 0, context: context)}
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    var hasSelectedAny: Bool{
        get{
            return self.categories.filter({$0.isSelected}).count > 0
        }
    }
}
struct OnboardingMappingView: View {
    @State var isPresented = false
    @State private var orientation = UIDeviceOrientation.unknown
    
    @ObservedObject var env: OnboardingEnvironment
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text("Escolha uma ou mais categorias de seu interesse")
                        .font(.largeTitle)
                    Text("Essas áreas armazenarão seus aprendizados menores")
                        .font(.title2)
                }
                Spacer()
            }
            .padding(40)
            VStack{
            LazyVGrid(columns: (orientation == .portrait || orientation == .faceUp ? [GridItem(), GridItem()]: [GridItem(), GridItem(), GridItem(), GridItem()]) , content: {
                ForEach(0..<env.categories.count, id: \.self){ index in
                    OnboardingMappingCategoryView(category: env.categories[index]).padding(10)
                }
                
            })
            .padding(30)
            Button(action:{
                if env.hasSelectedAny{
                    env.saveSelectedToCoreData()
                }
            }){
                HStack{
                    Spacer()
                Text("Concluir seleção")
                    .font(.title)
                    .foregroundColor(env.hasSelectedAny ? .white : .darkBlue)
                    .padding()
                    Spacer()
                }
                .background(env.hasSelectedAny ? Color.darkBlue : Color.white)
                .overlay(Rectangle().stroke(Color.darkBlue, lineWidth: 2))
                .padding(.horizontal, 40)
                
            }
            }
            Spacer()
        }
        .onRotate{ o in
            orientation = o
        }
        
    }
}

struct OnboardingMappingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingMappingView(env: OnboardingEnvironment())
            //.previewDevice("iPad (8th generation)")
            .previewLayout(.fixed(width: 1080, height: 810))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}
