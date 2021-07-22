//
//  HomeScreenEnvironment.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import Foundation
import CoreData
import SwiftUI

class HomeScreenEnvironment: ObservableObject, LearningDelegate{
    
    @Published var categories: [Category] = []
    let context = AppDelegate.viewContext
    
    @Published var fixedLearnings: [Learning] = []
    @Published var allLearnings: [Learning] = []
    
    @Published var didSelectNewCategory = false
    
    @Published var categorySelected: Category?
        
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.addNewLearningByCategoryView(_:)), name: .addNewLearningByCategoryView, object: nil)
        
        reset()
    }

    func reset(){
        print("resetted")
        categories = []
        allLearnings = []
        fixedLearnings = []
        
        let categoriesRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        categoriesRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        do {
            try categories = context.fetch(categoriesRequest)
        }catch{
            print(error)
        }
        
        let fixed = categories.map({ category in
            (category.learnings?.allObjects as! [Learning]).filter({learning in
                                                                    learning.isFixed == true})
            
        }).joined()
        fixedLearnings.append(contentsOf: fixed)
        
        let all = categories.map({ category in
            (category.learnings?.allObjects as! [Learning])
        }).joined()
        allLearnings.append(contentsOf: all)
        
        self.objectWillChange.send()
    }
    
    func createNewCategory(name: String, colorIndex: Int){
        
        if name == ""{
            print("Please insert a name")
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
    
    
    func saveNewLearning(categoryIndex: Int, title: String, description: String, emoji: String) {
        
        if title.isEmpty || description.isEmpty {
            return
        }
        
        let context = AppDelegate.viewContext
        let learning = Learning(name: title, descriptionText: description, emoji: emoji, estimatedTime: 0, text: "", context: context)
        
        categories[categoryIndex].addToLearnings(learning)
        learning.category = categories[categoryIndex]
        
        allLearnings.append(learning)
        do {
            try context.save()
            
        } catch {
            print(error)
        }
        
    }
    
    @objc func addNewLearningByCategoryView(_ note: NSNotification) {

    }

}
