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
    @Published var didSelectNewLearning = false
    
    @Published var categorySelected: Category?
    
    @Published var categoriesIsOpen: Bool = true
    @Published var lastCategory: Int = 0
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.addNewLearningByCategoryView(_:)), name: .addNewLearningByCategoryView, object: nil)
        
        reset()
    }
    init(_ any: Any?){
        
    }
    func resetFixedLearnings() {
        fixedLearnings = []
        
        let fixedsRequest: NSFetchRequest<Learning> = Learning.fetchRequest()
        
        fixedsRequest.predicate = NSPredicate(format: "isFixed == true")
        fixedsRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        do {
            try fixedLearnings = context.fetch(fixedsRequest)
            
        } catch {
            print(error)
        }
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
        
        let fixedsRequest: NSFetchRequest<Learning> = Learning.fetchRequest()
        
        fixedsRequest.predicate = NSPredicate(format: "isFixed == true")
        fixedsRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let learningsRequest: NSFetchRequest<Learning> = Learning.fetchRequest()
        
        learningsRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        do {
            try fixedLearnings = context.fetch(fixedsRequest)
            try allLearnings = context.fetch(learningsRequest)
        }catch{
            print(error)
        }
        
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
    
    func updateCategory(categoryIndex: Int, name: String, index: Int){
        categories[categoryIndex].name = name
        categories[categoryIndex].color = String(index)
        
        do{
            try context.save()
        }catch{
            print(error)
        }

        
    }
    
    func getLearningsFromCategory(_ index: Int)->[Learning]{
        let category = self.categories[index]
        var learnings = (category.learnings?.allObjects as! [Learning])
        learnings.sort(by: {(learning1, learning2) in
            learning1.creationDate! > learning2.creationDate!
        })
        learnings.sort(by: {(learning1, learning2) in
            learning1.isFixed && !learning2.isFixed
        })
        return learnings
    }
    
    func saveNewLearning(categoryIndex: Int, title: String, description: String, emoji: String) {
        
        if title.isEmpty || description.isEmpty {
            return
        }
        
        let context = AppDelegate.viewContext
        let learning = Learning(name: title, descriptionText: description, emoji: emoji, estimatedTime: 0, text: "", context: context)
        
        categories[categoryIndex].addToLearnings(learning)
        learning.category = categories[categoryIndex]
        
        allLearnings.insert(learning, at: 0)
        do {
            try context.save()
            
        } catch {
            print(error)
        }
        
    }
    
    @objc func addNewLearningByCategoryView(_ note: NSNotification) {

    }

}
