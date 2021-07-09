//
//  HomeScreenEnvironment.swift
//  Overseas
//
//  Created by Elaine  Cruz on 09/07/21.
//

import Foundation

class HomeScreenEnvironment: ObservableObject{
    var categories: [Category] = []
    let context = AppDelegate.viewContext
    
    init(){
        let category = Category(context: context)
        category.name = "Dança"
        category.color = "Roxo"
        categories.append(category)
    }
}
