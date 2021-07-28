//
//  Lerning.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 06/07/21.
//

import Foundation
import CoreData

class Learning: NSManagedObject {

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    
    convenience init(name: String, descriptionText: String?, emoji: String?, estimatedTime: TimeInterval?, text: String?, context: NSManagedObjectContext){
        self.init(context: context)
        
        self.name = name
        self.creationDate = Date()
        self.modificationDate = Date()
        self.descriptionText = descriptionText
        self.emoji = emoji
        self.estimatedTime = estimatedTime ?? 1
        self.text = text
        
        self.objectWillChange.send()
        
        
    }
    
    func toggleIsFixed() {
        self.isFixed.toggle()
        print("favoritou")
        
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print(error)
        }
    }
    
}
