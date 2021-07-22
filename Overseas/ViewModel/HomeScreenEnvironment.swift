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
        reset()
    }
    
    func reset(){
        print("oi resetttt")
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
        
        //DELETE COREDATA DATA
//        do {
//            for user in try context.fetch(categoriesRequest){
//                context.delete(user)
//            }
//           try context.save()
//
//        } catch{
//
//        }
        
        let fixed = categories.map({ category in
            (category.learnings?.allObjects as! [Learning]).filter({learning in
                                                                    learning.isFixed == true})
            
        }).joined()
        fixedLearnings.append(contentsOf: fixed)
        //print(fixed.count)
        
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
        
        self.objectWillChange.send()
    }
    
    func createNewCategory(name: String, colorIndex: Int){
        
        if name == ""{
            print("?????")
            return
        }
        
        let context = AppDelegate.viewContext
        
        
        let category = Category(name: name, color: colorIndex, context: context)
        print(category.name! + "ddddddd")
        categories.append(category)
        
        do{
            try context.save()
        }catch{
            print(error)
        }
        
    }
    
    
    func saveNewLearning(title: String, description: String, emoji: String) {
        
        if title.isEmpty || description.isEmpty {
            return
        }
        
        let context = AppDelegate.viewContext
        let learning = Learning(name: title, descriptionText: description, emoji: emoji, estimatedTime: 0, text: "", context: context)
        
        //learning.category = category
        //category.addToLearnings(learning)
        
        allLearnings.append(learning)
        do {
            try context.save()
            
        } catch {
            print(error)
        }
        
    }
    

}
