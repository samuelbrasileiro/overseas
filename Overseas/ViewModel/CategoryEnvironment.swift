//
//  CategoryEnvironment.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import Foundation
import CoreData
class CategoryEnvironment: ObservableObject/*, LearningDelegate*/{
    
    @Published var category: Category
    
    var index: Int
    
    @Published var fixedLearnings: [Learning] = []
    
    @Published var allLearnings: [Learning] = []
    
    let context = AppDelegate.viewContext

    init(category: Category, index: Int){
        self.category = category
        self.index = index
        
        self.reset()
    }
    
    
    func reset(){
        allLearnings = category.learnings?.allObjects as! [Learning]
        
        allLearnings.sort(by: {(learning1, learning2) in
            learning1.isFixed && !learning2.isFixed
        })
    }
    
    
}
