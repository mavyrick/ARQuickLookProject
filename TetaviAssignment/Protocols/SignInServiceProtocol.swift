//
//  LoginProtocol.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 02/07/2021.
//

protocol SignInServiceProtocol {
    typealias SignInCompletion = (_ result: AuthResult, _ message: String?) -> ()
    func signIn(email: String, password: String, completion: @escaping SignInCompletion)
}
