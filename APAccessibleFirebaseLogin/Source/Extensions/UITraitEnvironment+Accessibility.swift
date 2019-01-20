//
//  UITraitEnvironment+Accessibility.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 29/12/2018.
//  Copyright © 2018 Warren Gavin. All rights reserved.
//

import UIKit

extension UITraitEnvironment {
    var isDisplayingLargeText: Bool {
        return traitCollection.preferredContentSizeCategory.isAccessibilityCategory
    }
}

