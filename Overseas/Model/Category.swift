//
//  Area.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 06/07/21.
//

import Foundation
import CoreData

class Category: NSManagedObject {
    
    convenience init(name: String, color: Int, context: NSManagedObjectContext){
        self.init(context: context)
        
        self.name = name
        self.color = String(color)
        //self.creationDate = Date()
        
        self.objectWillChange.send()
    }
 
}
