//
//  NewsFeedItem.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 01/07/2021.
//

struct NewsFeedItem {
    
    let id: String
    let modelName: String
    let modelImageName: String?
    let animated: Bool
    let likes: Int
    let title: String?
    
    init(id: String, modelName: String, modelImageName: String, animated: Bool, likes: Int, title: String) {
        self.id = id
        self.modelName = modelName
        self.modelImageName = modelImageName
        self.animated = animated
        self.likes = likes
        self.title = title
    }
    
}
