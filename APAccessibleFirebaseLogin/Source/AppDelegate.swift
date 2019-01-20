//
//  AppDelegate.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 28/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.tintColor = #colorLiteral(red: 0.06274509804, green: 0.1254901961, blue: 0.4117647059, alpha: 1)
        FirebaseApp.configure()
        disableActivitySpinnerPresentation()
        
        return true
    }
    
    func disableActivitySpinnerPresentation() {
        guard
            let method = class_getClassMethod(FUIAuthBaseViewController.self,
                                              #selector(FUIAuthBaseViewController.addActivityIndicator(_:)))
        else {
            return
        }

        let emptyBlock: @convention(block) (UIView) -> UIActivityIndicatorView? = { _ in
            return nil
        }
        
        method_setImplementation(method, imp_implementationWithBlock(emptyBlock))
    }

}

