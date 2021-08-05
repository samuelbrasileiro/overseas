//
//  OnboardingMappingView.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 09/07/21.
//

import SwiftUI
import CoreData

extension String {
    func localized() -> String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")!
        if let bundle = Bundle(path: path) {
            let str = bundle.localizedString(forKey: self, value: nil, table: nil)
            return str
        }
        return ""
    }
}

class OnboardingEnvironment: ObservableObject{
    @Published var categories: [SelectionCategory] = []
    var categoriesName: [LocalizedStringKey] = []
    
    
    init(){
        categories.append(contentsOf: [("Culinária".localized(),"🧑‍🍳"), ("Investimento".localized(),"💸"), ("Música".localized(),"🎵"), ("Manutenção da casa".localized(),"🔧"), ("Videogames".localized(),"🎮"), ("Cabelo".localized(),"💈"), ("Animais de estimação".localized(),"🐶"), ("Skin Care".localized(),"🧼") ].map{.init(name: $0.0, emoji: $0.1)})
    }
    
    func saveSelectedToCoreData(){
        let context = AppDelegate.viewContext
        
        _ = self.categories.filter({$0.isSelected}).map{Category(name: $0.name, color: (0..<4).randomElement()!, context: context)}
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
    @State private var orientation: UIDeviceOrientation = .unknown
    var delegate: OnboardingDelegate?
    
    @ObservedObject var env: OnboardingEnvironment
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text("Escolha uma ou mais categorias de seu interesse")
                        .font(.largeTitle)
                    Text("Essas áreas armazenarão seus aprendizados")
                        .font(.title2)
                }
                Spacer()
            }
            .padding(30)
            VStack{
                LazyVGrid(columns: (UIScreen.main.bounds.height > 900 ? [GridItem(), GridItem(), GridItem()]: [GridItem(), GridItem(), GridItem(), GridItem()]) , content: {
                    
                    ForEach(0..<env.categories.count, id: \.self){ index in
                        OnboardingMappingCategoryView(category: $env.categories[index]).padding(10)
                    }
                    
                })
                .padding(20)
                
                Spacer()
                
                Button(action:{
                    if env.hasSelectedAny{
                        env.saveSelectedToCoreData()
                        UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                        delegate?.changeRootToHomeScreen()
                    }
                }){
                    HStack{
                        Spacer()
                        Text("Concluir seleção")
                            .font(.title)
                            .foregroundColor(env.hasSelectedAny ? Color(.systemBackground) : .darkBlue)
                            .padding()
                        Spacer()
                    }
                    .background(env.hasSelectedAny ? Color.darkBlue : Color(.systemBackground))
                    .overlay(Rectangle().stroke(Color.darkBlue, lineWidth: 2))
                    .padding(.horizontal, 40)
                    
                }.padding(.bottom, 80)
            }
            Spacer()
        }
        .onRotate{ o in
            orientation = o
            env.objectWillChange.send()
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
