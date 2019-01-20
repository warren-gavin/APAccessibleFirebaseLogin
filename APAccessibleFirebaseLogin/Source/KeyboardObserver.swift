//
//  KeyboardObserver.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 13/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import UIKit

class KeyboardObserver {
    private let anchor: NSLayoutConstraint
    private let originalAnchorConstant: CGFloat

    init(anchoredTo anchor: NSLayoutConstraint) {
        self.anchor = anchor
        self.originalAnchorConstant = anchor.constant
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardObserver.keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardObserver.keyboardWillHide(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension KeyboardObserver {
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        let animation: (CGRect) -> Void = { rect in
            self.anchor.constant = -rect.size.height
        }
        
        animateAlongsideKeyboard(keyboardInfo: notification.userInfo as? [String: NSValue],
                                 animation: animation)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        let animation: (CGRect) -> Void = { rect in
            self.anchor.constant = self.originalAnchorConstant
        }
        
        animateAlongsideKeyboard(keyboardInfo: notification.userInfo as? [String: NSValue],
                                 animation: animation)
    }
}

private extension KeyboardObserver {
    func animateAlongsideKeyboard(keyboardInfo: [String: NSValue]?, animation: @escaping (CGRect) -> Void) {
        guard
            let endFrame = keyboardInfo?[UIResponder.keyboardFrameEndUserInfoKey]?.cgRectValue,
            let duration = keyboardInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let options = keyboardInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else {
            return
        }
        
        // The keyboard animation is not documented, so we have to hack the value a little to get it out of the keyboard info
        var animationCurve = UIView.AnimationOptions.curveEaseInOut
        NSNumber(value: options.intValue << 16).getValue(&animationCurve)
        
        let animateAndLayout: () -> Void = {
            animation(endFrame)
            
            if let view = self.anchor.firstItem as? UIView {
                view.superview?.layoutIfNeeded()
            }
        }
        
        UIView.animate(withDuration: duration.doubleValue,
                       delay: 0.0,
                       options: animationCurve,
                       animations: animateAndLayout,
                       completion: nil)
    }
}
