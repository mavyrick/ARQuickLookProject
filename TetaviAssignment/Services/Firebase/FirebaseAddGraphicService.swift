//
//  FirebaseAddGraphicService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 04/07/2021.
//

import Firebase

class FirebaseAddGraphicService: AddGraphicServiceProtocol {
    
    func addGraphic(newsFeedItem: NewsFeedItem, completion: @escaping () -> Void) {
        
        let db = Firestore.firestore()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        db.collection("users_graphics").document(currentUser.uid).collection("my_graphics").document(newsFeedItem.id).setData([
            "modelID": newsFeedItem.id,
            "modelName": newsFeedItem.modelName,
            "modelImageName": newsFeedItem.modelImageName ?? "placeholder",
            "animated": newsFeedItem.animated
        ])
        
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                completion()
            }
        }
        
    }
    
}
