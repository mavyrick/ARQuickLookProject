//
//  FirebaseSignInService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 02/07/2021.
//

import UIKit
import Firebase

class FirebaseSignInService: SignInServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping SignInCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                
                print(error)
                
                completion(AuthResult.error, error.localizedDescription)
                
            } else {
                
                completion(AuthResult.success, "Authentication wsa a success")
                
            }
            
        }
    }
    
}
