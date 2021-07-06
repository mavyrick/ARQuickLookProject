//
//  MyGraphicsItem.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 04/07/2021.
//

struct MyGraphicsItem {
    
    let id: String
    let modelName: String
    let modelImageName: String?
    let animated: Bool
    
    init(id: String, modelName: String, modelImageName: String, animated: Bool) {
        self.id = id
        self.modelName = modelName
        self.modelImageName = modelImageName
        self.animated = animated
    }
    
}
