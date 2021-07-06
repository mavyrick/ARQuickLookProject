//
//  FirebaseSignUpService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 02/07/2021.
//

import UIKit
import Firebase

class FirebaseSignUpService: SignUpServiceProtocol {
    func signUp(email: String, password: String, displayName: String, completion: @escaping SignUpCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                
                completion(AuthResult.error, error.localizedDescription)
                
            } else {
                
                if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                    
                    currentUser.displayName = displayName
                    
                    currentUser.commitChanges { error in
                        if let error = error {
                            
                            completion(AuthResult.error, error.localizedDescription)
                            
                            
                            print(error)
                        } else {
                            completion(AuthResult.success, "Authentication wsa a success")
                        }
                    }
                }
            }
        }
    }
    
}
