//
//  CategoryEnvironment.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import Foundation
import CoreData
class CategoryEnvironment: ObservableObject{
    
    @Published var category: Category
    
    @Published var fixedLearnings: [Learning] = []
    
    @Published var allLearnings: [Learning] = []
    
    let context = AppDelegate.viewContext

    init(category: Category){
        self.category = category
        
        //let category = Category(name: "Culinária", color: 0, context: context)
        
        for j in (0..<10){
            let learning = Learning(name: "Sushi \(j)", descriptionText: "Aprendi sushi poxa", emoji: "🍣", estimatedTime: 1, text: "Uhhh aprendi a fazer sushi hoje", context: context)
            
            if j % 5 == 0{
                learning.isFixed = true
            }
            
            category.addToLearnings(learning)
            learning.category = category
        }
        self.category = category
        
        
        
        //fixedLearnings = (category.learnings?.allObjects as! [Learning]).filter({learning in
        //                                                                            learning.isFixed == true})
        
        
        allLearnings = (category.learnings?.allObjects as! [Learning])
        
        allLearnings.sort(by: {(learning1, learning2) in
            learning1.isFixed && !learning2.isFixed
        })
    }
    
}
