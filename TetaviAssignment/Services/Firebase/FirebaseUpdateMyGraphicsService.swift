//
//  FirebaseUpdateMyGraphicsService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 04/07/2021.
//

import Firebase

class FirebaseUpdateMyGraphicsService: UpdateMyGraphicsServiceProtocol {
    
    func updateMyGraphicsData(completion: @escaping UpdateMyGraphicsCompletion) {
        
        let db = Firestore.firestore()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        db.collection("users_graphics").document(currentUser.uid).collection("my_graphics").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            var myGraphicsItems: [MyGraphicsItem] = []
            
            for doc in documents {
                let id = doc.documentID
                let snapshot = doc.data()
                let myGraphicsItem = MyGraphicsItem(
                    id: id,
                    modelName: snapshot["modelName"] as? String ?? "",
                    modelImageName: snapshot["modelImageName"] as? String ?? "",
                    animated: snapshot["animated"] as? Bool ?? false
                )
                
                myGraphicsItems.append(myGraphicsItem)
                
            }
            
            completion(myGraphicsItems, nil)
        }
        
    }
    
}
