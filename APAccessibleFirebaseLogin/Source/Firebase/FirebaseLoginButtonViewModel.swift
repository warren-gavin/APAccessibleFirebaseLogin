//
//  FirebaseLoginButtonViewModel.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 29/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import FirebaseUI

struct FirebaseLoginButtonViewModel {
    /// If the provider is nil we default to email
    let provider: FUIAuthProvider?
    
    var buttonBackgroundColor: UIColor {
        return provider?.buttonBackgroundColor ?? FirebaseEmailAuthentication.buttonBackgroundColor
    }
    
    var signInLabel: String {
        if UIScreen.main.isDisplayingLargeText {
            return provider?.shortName ?? FirebaseEmailAuthentication.shortName
        }
        
        return provider?.signInLabel ?? FirebaseEmailAuthentication.signInLabel
    }
    
    var icon: UIImage {
        return provider?.icon ?? FirebaseEmailAuthentication.icon
    }
    
    var buttonBorderColor: UIColor {
        return provider?.buttonTextColor ?? FirebaseEmailAuthentication.buttonBorderColor
    }
    
    var buttonTextColor: UIColor {
        return provider?.buttonTextColor ?? FirebaseEmailAuthentication.buttonTextColor
    }

    var buttonBorderWidth: CGFloat {
        return (buttonBorderColor == .clear ? 0.0 : 1.0)
    }
}
