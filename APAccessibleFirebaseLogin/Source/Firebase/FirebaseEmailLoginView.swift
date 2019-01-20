//
//  FirebaseEmailLoginView.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 12/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseEmailLoginView: UIView {
    @IBOutlet var textEntryViews: [UIStackView]!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var completion: AuthDataResultCallback = { _, _ in }

    @IBAction
    func signIn(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
        else {
            return
        }
        
        loginOrCreateUser(withEmail: email, password: password)
    }
}

extension FirebaseEmailLoginView {
    func loginOrCreateUser(withEmail email: String, password: String) {
        Auth.auth().fetchProviders(forEmail: email) { [weak self] providers, error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.completion(nil, error)
                return
            }
            
            if (providers ?? []).contains("password") {
                Auth.auth().signIn(withEmail: email,
                                   password: password,
                                   completion: self.completion)
            }
            else {
                Auth.auth().createUser(withEmail: email,
                                       password: password,
                                       completion: self.completion)
            }
        }
    }
}

extension FirebaseEmailLoginView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let axis: NSLayoutConstraint.Axis = (isDisplayingLargeText && traitCollection.horizontalSizeClass == .compact ? .vertical : .horizontal)
        
        textEntryViews.forEach {
            $0.axis = axis
        }
    }
}
