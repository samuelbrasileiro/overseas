//
//  Area.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 06/07/21.
//

import Foundation
import CoreData

class Category: NSManagedObject {
    
    convenience init(name:String, color: String){
        self.init()


        self.name = name
        self.color = color
    }
    
 
}
