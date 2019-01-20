//
//  FirebaseLoginViewController.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 30/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class FirebaseLoginViewController: UIViewController {
    private let loginTypes: [FirebaseLoginType]
    private let onLogin: (Result<String>) -> Void
    
    init(with loginTypes: [FirebaseLoginType], onLogin: @escaping (Result<String>) -> Void) {
        self.loginTypes = loginTypes
        self.onLogin = onLogin

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = FirebaseBundle.localizedString(FirebaseBundle.loginLabel)
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: loginTypes.map(loginButton(for:)))
        stackView.axis = .vertical
        stackView.spacing = FirebaseLoginViewController.buttonSpacing
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -FirebaseLoginViewController.buttonSpacing).isActive = true
    }
}

private extension FirebaseLoginViewController {
    static let buttonSpacing: CGFloat = 24.0
    static let buttonWidth: CGFloat = 250.0
    
    @objc
    func login(_ sender: FirebaseLoginButton) {
        guard let authProvider = sender.provider else {
            loginWithEmail()
            return
        }
        
        login(with: authProvider)
    }
    
    func loginWithEmail() {
        let emailLoginViewController: FirebaseEmailLoginViewController = UIStoryboard.main.instance()
        
        emailLoginViewController.completion = { [unowned self] (result, error) in
            guard let result = result else {
                self.onLogin(.failure(error))
                return
            }
            
            self.onLogin(.success(result.user.displayName ?? result.user.email ?? "Stranger"))
        }
        
        show(emailLoginViewController, sender: self)
    }

    func login(with authProvider: FUIAuthProvider) {
        authProvider.signOut()
        
        authProvider.signIn(withDefaultValue: nil, presenting: self) { (credential, providerError, callback) in
            guard let credential = credential else {
                callback?(nil, providerError)
                self.onLogin(.failure(providerError))
                return
            }
            
            Auth.auth().signInAndRetrieveData(with: credential) { [unowned self] (result: AuthDataResult?, authError: Error?) in
                guard let result = result else {
                    callback?(nil, authError)
                    self.onLogin(.failure(authError))
                    return
                }
                
                callback?(result.user, nil)
                self.onLogin(.success(result.user.displayName ?? "Stranger"))
            }
        }
    }

    func loginButton(for loginType: FirebaseLoginType) -> FirebaseLoginButton {
        let button = FirebaseLoginButton(with: FirebaseLoginButtonViewModel(provider: loginType.authProvider))
        
        button.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 2 * FirebaseLoginButton.cornerRadius).isActive = true
        button.widthAnchor.constraint(equalToConstant: FirebaseLoginViewController.buttonWidth).isActive = true
        
        return button
    }
}
