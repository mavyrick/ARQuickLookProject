//
//  FirebaseDeleteGraphicService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 06/07/2021.
//

import Firebase

class FirebaseDeleteGraphicService: DeleteGraphicServiceProtocol {
    
    func deleteGraphic(graphicID: String) {
        
        let db = Firestore.firestore()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        db.collection("users_graphics").document(currentUser.uid).collection("my_graphics").document(graphicID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
    }
    
}
