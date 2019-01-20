//
//  ViewController.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 28/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.numberOfLines = 0
        
        button.setTitle(FirebaseBundle.localizedString(FirebaseBundle.loginLabel), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.06274509804, green: 0.1254901961, blue: 0.4117647059, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.9960784314, blue: 1, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    }
}

private extension ViewController {
    @objc
    func login(_ sender: UIButton) {
        let loginViewController = FirebaseLoginViewController(with: [.google, .email]) { [unowned self] result in
            switch result {
            case .success(let user):
                self.loginButton.setTitle("Welcome \(user)", for: .normal)
                
            case .failure(_):
                self.loginButton.setTitle("Login failed", for: .normal)
            }
            
            self.loginButton.isUserInteractionEnabled = false
            self.dismiss(animated: true, completion: nil)
        }
        
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        navigationController.navigationBar.topItem?.leftBarButtonItem = cancelButton
        
        show(navigationController, sender: sender)
    }
    
    @objc
    func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

