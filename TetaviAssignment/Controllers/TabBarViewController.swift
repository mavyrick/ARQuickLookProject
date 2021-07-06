//
//  TabBarViewController.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 05/07/2021.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutButtonTapped(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            return
        }
        performSegue(withIdentifier: "SignOutSegue", sender: nil)
    }
    
}
