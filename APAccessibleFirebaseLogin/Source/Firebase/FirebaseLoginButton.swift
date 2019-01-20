//
//  FirebaseLoginButton.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 28/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import FirebaseUI

struct FirebaseLoginType {
    let authProvider: FUIAuthProvider?
    
    static let google = FirebaseLoginType(authProvider: FUIGoogleAuth())
    static let twitter = FirebaseLoginType(authProvider: FUITwitterAuth())
    static let phone = FirebaseLoginType(authProvider: FUIPhoneAuth(authUI: FUIAuth.defaultAuthUI()!))
    static let facebook = FirebaseLoginType(authProvider: FUIFacebookAuth())
    static let email = FirebaseLoginType(authProvider: nil)
}

class FirebaseLoginButton: UIButton {
    static let cornerRadius: CGFloat = 20.0
    
    private let viewModel: FirebaseLoginButtonViewModel

    init(with viewModel: FirebaseLoginButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirebaseLoginButton {
    var provider: FUIAuthProvider? {
        return viewModel.provider
    }
}

private extension FirebaseLoginButton {
    static let inset: CGFloat = 16.0

    func setup() {
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel?.numberOfLines = 0

        layer.cornerRadius = FirebaseLoginButton.cornerRadius
        contentHorizontalAlignment = .left

        backgroundColor = viewModel.buttonBackgroundColor
        layer.borderColor = viewModel.buttonBorderColor.cgColor
        layer.borderWidth = viewModel.buttonBorderWidth
        
        setTitle(viewModel.signInLabel, for: .normal)
        setTitleColor(viewModel.buttonTextColor, for: .normal)
        setImage(viewModel.icon, for: .normal)

        titleEdgeInsets = UIEdgeInsets(top: 0, left: FirebaseLoginButton.inset, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: FirebaseLoginButton.inset * 0.667, bottom: 0, right: 0)
    }
}
