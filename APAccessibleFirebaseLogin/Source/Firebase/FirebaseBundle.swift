//
//  FirebaseBundle.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 05/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import UIKit

struct FirebaseBundle {
    static let loginLabel = "Login"
    static let emailIcon = "ic_email"
    static let bundleName = "FirebaseAuthUI"
    static let emailShortName = "Email"
    static let emailSignInLabel = "SignInWithEmail"
    
    private static let bundle: Bundle = {
        guard
            let firebaseBundleURL = Bundle.main.url(forResource: bundleName, withExtension: "bundle"),
            let bundle = Bundle(url: firebaseBundleURL)
        else {
            fatalError("Missing FirebaseAuthUI bundle")
        }
        
        return bundle
    }()
    
    static func localizedString(_ key: String) -> String {
        return bundle.localizedString(forKey: key, value: nil, table: bundleName)
    }
    
    static func image(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: bundle, compatibleWith: nil) else {
            fatalError("Invalid bundle contents")
        }
        
        return image
    }
}
