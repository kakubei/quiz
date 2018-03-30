//
//  UIViewExtension.swift
//  Quiz
//
//  Created by Alex Dearden on 14/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult public func addTapGestureHandler(target: Any, action: Selector) -> Self {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        return self
    }
    
    @discardableResult public func addSwipeLeftGestureHandler(target: Any, action: Selector) -> Self {
        self.isUserInteractionEnabled = true
        let swipeLeft = UISwipeGestureRecognizer(target: target, action: action)
        swipeLeft.direction = .left
        self.addGestureRecognizer(swipeLeft)
        return self
    }
    
    @discardableResult public func addSwipeUpGestureHandler(target: Any, action: Selector) -> Self {
        self.isUserInteractionEnabled = true
        let swipeUp = UISwipeGestureRecognizer(target: target, action: action)
        swipeUp.direction = .up
        self.addGestureRecognizer(swipeUp)
        return self
    }
    
    @discardableResult public func addSwipeDownGestureHandler(target: Any, action: Selector) -> Self {
        self.isUserInteractionEnabled = true
        let swipeDown = UISwipeGestureRecognizer(target: target, action: action)
        swipeDown.direction = .down
        self.addGestureRecognizer(swipeDown)
        return self
    }
    
}

protocol Dismissable {
    func dismissView()
}
