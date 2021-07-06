//
//  NetworkServiceProtocol.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 03/07/2021.
//

protocol UpdateNewsFeedServiceProtocol {
  typealias UpdateNewsFeedCompletion = ([NewsFeedItem], Error?) -> ()
  func updateNewsFeedData(completion: @escaping UpdateNewsFeedCompletion)
}
