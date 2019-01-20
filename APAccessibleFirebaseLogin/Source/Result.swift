//
//  Result.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 13/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}
