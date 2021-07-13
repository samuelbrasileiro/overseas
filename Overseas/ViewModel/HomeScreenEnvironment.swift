//
//  HomeScreenEnvironment.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import Foundation
import CoreData
import SwiftUI

class HomeScreenEnvironment: ObservableObject{
    @Published var categories: [Category] = []
    let context = AppDelegate.viewContext
    
    @Published var fixedLearnings: [Learning] = []
    @Published var allLearnings: [Learning] = []
    
    @Published var didSelectNewCategory = false
    
    
    init(){
        
//        for i in (0..<10){
//            let category = Category(name: "Culinária \(i)", color: 0, context: context)
//
//            for j in (0..<10){
//                let learning = Learning(name: "Fazer sushi \(j)", descriptionText: "Aprendi sushi", emoji: "🍣", estimatedTime: 1, text: "Uhhh aprendi a fazer sushi hoje", context: context)
//
//                if j % 3 == 0{
//                    learning.isFixed = true
//                }
//
//                category.addToLearnings(learning)
//                learning.category = category
//            }
//            categories.append(category)
//
//        }
        
        
        let fixed = categories.map({ category in
            (category.learnings?.allObjects as! [Learning]).filter({learning in
                                                                    learning.isFixed == true})
            
        }).joined()
        fixedLearnings.append(contentsOf: fixed)
        print(fixed.count)
        
        let all = categories.map({ category in
            (category.learnings?.allObjects as! [Learning])
        }).joined()
        allLearnings.append(contentsOf: all)
        print(fixed.count)
        for category in categories{
            print(category.name! + ":")
            for learnin in category.learnings?.allObjects as! [Learning]{
                print("\t" + learnin.name!)
                
            }
        }
        
    }
    
    func createNewCategory(name: String, colorIndex: Int){
        
        if name == ""{
            return
        }
        
        let context = AppDelegate.viewContext
        
        
        let category = Category(name: name, color: colorIndex, context: context)
        
        categories.append(category)
        
        do{
            try context.save()
        }catch{
            print(error)
        }
        
    }
    
    

}
