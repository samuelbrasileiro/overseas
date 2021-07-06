//
//  Lerning.swift
//  Overseas
//
//  Created by Ana Carolina Soares de Melo on 06/07/21.
//

import Foundation

class LearningModel: ObservableObject {
    @Published var name: String
    @Published var description: String?
    @Published var emoji: String?
    @Published var creationDate: Date
    @Published var modificationDate: Date
    @Published var estimatedTime: TimeInterval?
    @Published var text: String?
    
    init(name: String){
        self.name = name
        self.creationDate = Date()
        self.modificationDate = Date()
    }
    
}

extension Learning {
    func creatLearning(){
        name = "Samuel"
    }
}
