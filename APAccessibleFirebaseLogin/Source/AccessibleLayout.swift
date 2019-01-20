//
//  AccessibleLayout.swift
//  APAccessibleFirebaseLogin
//
//  Created by Warren Gavin on 19/01/2019.
//  Copyright © 2019 Warren Gavin. All rights reserved.
//

import UIKit

class AccessibleLayout {
    private let initialHeights: [CGFloat]
    private let adjustableConstraints: [NSLayoutConstraint]
    private let scrollView: UIScrollView
    private let stackView: UIStackView

    private var scrollViewBoundsChangeObserver: NSKeyValueObservation!
    private var stackViewBoundsChangeObserver: NSKeyValueObservation!
    
    init(scrollView: UIScrollView, stackView: UIStackView, adjustableConstraints: [NSLayoutConstraint]) {
        self.scrollView = scrollView
        self.stackView = stackView
        self.adjustableConstraints = adjustableConstraints
        self.initialHeights = adjustableConstraints.map { $0.constant }

        scrollViewBoundsChangeObserver = scrollView.observe(\.bounds, options: .new, changeHandler: handleBoundsChange)
        stackViewBoundsChangeObserver = stackView.observe(\.bounds, options: .new, changeHandler: handleBoundsChange)
    }
}

private extension AccessibleLayout {
    func handleBoundsChange<View, Value>(view: View, change: NSKeyValueObservedChange<Value>) {
        guard !adjustableConstraints.isEmpty else {
            return
        }
        
        let paddingSize = adjustableConstraints.reduce(0) { $0 + $1.constant }
        let originalSize = initialHeights.reduce(0, +)
        
        let heightDifference = scrollView.bounds.height - stackView.bounds.height + paddingSize - originalSize
        
        if heightDifference > 0 {
            zip(adjustableConstraints, initialHeights).forEach {
                $0.constant = $1 + (heightDifference / CGFloat(adjustableConstraints.count))
            }
        }
        else if heightDifference < 0 {
            zip(adjustableConstraints, initialHeights).forEach {
                $0.constant = $1
            }
        }
    }
}
