//
//  SignUpServiceProtocol.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 02/07/2021.
//

protocol SignUpServiceProtocol {
    typealias SignUpCompletion = (_ result: AuthResult, _ message: String?) -> ()
    func signUp(email: String, password: String, displayName: String, completion: @escaping SignUpCompletion)
}
