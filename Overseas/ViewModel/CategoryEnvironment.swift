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
    
    func updateCategory(category: Category){
        self.category = category
        self.reset()
    }
    
    func reset(){
        allLearnings = category.learnings?.allObjects as! [Learning]
        
        allLearnings.sort(by: {(learning1, learning2) in
            learning1.isFixed && !learning2.isFixed
        })
    }
    
//    func saveNewLearning(title: String, description: String, emoji: String) {
//        
//        if title.isEmpty || description.isEmpty {
//            return
//        }
//        
//        let context = AppDelegate.viewContext
//        let learning = Learning(name: title, descriptionText: description, emoji: emoji, estimatedTime: 0, text: "", context: context)
//        
//        learning.category = category
//        category.addToLearnings(learning)
//        
//        allLearnings.append(learning)
//        
//        allLearnings.sort(by: {(learning1, learning2) in
//            learning1.isFixed && !learning2.isFixed
//        })
//        
//        do {
//            try context.save()
//            
//        } catch {
//            print(error)
//        }
//        
//        //NotificationCenter.default.post(name: .addNewLearningByCategoryView, object: learning)
//        
//    }
    
    
}
