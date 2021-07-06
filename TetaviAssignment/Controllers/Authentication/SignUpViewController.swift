//
//  SignUpViewController.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 02/07/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let signUpService: SignUpServiceProtocol = FirebaseSignUpService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        keyboardResponsiveness()
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        
        
        let email = emailTextField.text!
        let displayName = displayNameTextField.text!
        let password = passwordTextField.text!
        
        guard !email.isEmpty && !displayName.isEmpty && !password.isEmpty else {
            
            let alertController = UIAlertController(title: nil, message:
                                                        "All form fields are required.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.displayAlert(alertController: alertController)
            
            return
            
        }
        
        spinner.isHidden = false
        
        signUpService.signUp(email: email, password: password, displayName: displayName, completion: { (authResult, message) -> Void in
            
            if (authResult == .error) {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.spinner.isHidden = true
                    self.displayAlert(alertController: alertController)
                }
            } else {
                DispatchQueue.main.async {
                    self.spinner.isHidden = true
                    self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                }
            }
            
        })
    }
    
    func keyboardResponsiveness() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func displayAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
}
