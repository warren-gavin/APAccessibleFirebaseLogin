//
//  FirebaseEmailAuthentication.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 30/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import UIKit

struct FirebaseEmailAuthentication {
    static let icon = FirebaseBundle.image(named: FirebaseBundle.emailIcon)
    static let shortName = FirebaseBundle.localizedString(FirebaseBundle.emailShortName)
    static let signInLabel = FirebaseBundle.localizedString(FirebaseBundle.emailSignInLabel)

    static let buttonBackgroundColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
    static let buttonBorderColor = UIColor.clear
    static let buttonTextColor = UIColor.white
}
