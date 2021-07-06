//
//  UpdateMyGraphicsProtocol.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 04/07/2021.
//

protocol UpdateMyGraphicsServiceProtocol {
  typealias UpdateMyGraphicsCompletion = ([MyGraphicsItem], Error?) -> ()
  func updateMyGraphicsData(completion: @escaping UpdateMyGraphicsCompletion)
}
