//
//  FirebaseEmailLoginViewController.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 13/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseEmailLoginViewController: UIViewController {
    private var keyboardObserver: KeyboardObserver!
    private var accessibleLayoutHandler: AccessibleLayout!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var adjustableViewConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var loginView: FirebaseEmailLoginView! {
        didSet {
            loginView.completion = completion
        }
    }

    @IBOutlet var bottomConstraint: NSLayoutConstraint! {
        didSet {
            keyboardObserver = KeyboardObserver(anchoredTo: bottomConstraint)
        }
    }
    
    var completion: AuthDataResultCallback = { _, _ in }

    override func viewDidLoad() {
        super.viewDidLoad()

        accessibleLayoutHandler = AccessibleLayout(scrollView: scrollView,
                                                   stackView: stackView,
                                                   adjustableConstraints: adjustableViewConstraints)
    }
}

