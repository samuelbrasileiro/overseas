//
//  Area.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 06/07/21.
//

import Foundation

class AreaModel1: ObservableObject {
    @Published var name: String
    @Published var color: String?
    @Published var learnings: [LearningModel] = []
    
    init(name: String, color: String?){
        self.name = name
        self.color = color
    }
    
    init(name: String){
        self.name = name
    }
}
