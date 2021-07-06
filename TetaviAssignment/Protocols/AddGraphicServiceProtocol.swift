//
//  AddGraphicServiceProtocol.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 04/07/2021.
//

protocol AddGraphicServiceProtocol {
    func addGraphic(newsFeedItem: NewsFeedItem, completion: @escaping () -> Void)
}

