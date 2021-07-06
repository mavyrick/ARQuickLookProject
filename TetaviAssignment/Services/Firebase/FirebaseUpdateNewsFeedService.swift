//
//  FirebaseService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 02/07/2021.
//

import Firebase

class FirebaseUpdateNewsFeedService: UpdateNewsFeedServiceProtocol {
    func updateNewsFeedData(completion: @escaping UpdateNewsFeedCompletion) {
        
        let db = Firestore.firestore()
        
        db.collection("global-news-feed").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            var newsFeedItems: [NewsFeedItem] = []
            
            for doc in documents {
                let id = doc.documentID
                let snapshot = doc.data()
                let newsFeedItem = NewsFeedItem(
                    id: id,
                    modelName: snapshot["modelName"] as? String ?? "",
                    modelImageName: snapshot["modelImageName"] as? String ?? "",
                    animated: snapshot["animated"] as? Bool ?? false,
                    likes: snapshot["likes"] as? Int ?? 0,
                    title: snapshot["title"] as? String ?? ""
                )
                
                newsFeedItems.append(newsFeedItem)
                
            }
            
            completion(newsFeedItems, nil)
        }
        
    }
    
}

