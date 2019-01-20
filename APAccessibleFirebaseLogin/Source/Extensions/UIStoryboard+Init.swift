//
//  UIStoryboard+Init.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 13/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instance<T: UIViewController>() -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}
