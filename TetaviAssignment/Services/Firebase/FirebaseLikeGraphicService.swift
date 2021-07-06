//
//  FirebaseLikeGraphicService.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 03/07/2021.
//

import Firebase

class FirebaseLikeGraphicService: LikeGraphicServiceProtocol {
    
    func likeGraphic(id: String) {
        
        let db = Firestore.firestore()
        let graphicRef = db.collection("global-news-feed").document(id)
        graphicRef.updateData([
            "likes": FieldValue.increment(Int64(1))
        ])
        
    }
    
}

