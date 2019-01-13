//
//  UIDesignable.swift
//  UIDesignables
//
//  Created by Erick Sanchez on 5/14/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

public struct UIDesignable<View: UIView> {
    
    private(set) var view: View

    private init(view: View) {
        self.view = view
    }

    // MARK: - Public Inits

    @discardableResult
    public static func wrapDesignable<T: UIView>(to view: T) -> UIDesignable<T> {
        let designable = UIDesignable<T>(view: view)

        return designable
    }

    @discardableResult
    public static func applyRoundedRect<T: UIView>(to view: T) -> UIDesignable<T> {
        let designable = UIDesignable<T>(view: view)
        designable.cornerRadius(4.0)
            .outlineWidth(1.0)
            .outlineColor(UIColor.blue)

        return designable
    }

    @discardableResult
    public static func applyCircle<T: UIView>(to view: T) -> UIDesignable<T> {
//        view.transformToSquare()

        let designable = UIDesignable<T>(view: view)
        let radius = view.bounds.height / 2.0
        designable.cornerRadius(radius)

        return designable
    }

    // MARK: - Methods

    @discardableResult
    public func bgColor(_ color: UIColor?) -> UIDesignable {
        self.view.layer.backgroundColor = color?.cgColor

        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> UIDesignable {
        self.view.layer.cornerRadius = radius

        return self
    }

    @discardableResult
    public func outlineWidth(_ width: CGFloat) -> UIDesignable {
        self.view.layer.borderWidth = width

        return self
    }

    @discardableResult
    public func outlineColor(_ color: UIColor?) -> UIDesignable {
        self.view.layer.borderColor = color?.cgColor

        return self
    }

    /**
     applies to contentEdgeInsets if view is a button. Otherwise, to layoutMargins
     */
    @discardableResult
    public func margin(_ margin: UIEdgeInsets) -> UIDesignable {
        if let button = self.view as? UIButton {
            button.contentEdgeInsets = margin
        } else {
            self.view.layoutMargins = margin
        }

        return self
    }
}

extension UIDesignable where View == UIButton {
    
    @discardableResult
    func title(font: UIFont) -> UIDesignable {
        self.view.titleLabel?.font = font
        
        return self
    }
    
    @discardableResult
    func title(color: UIColor) -> UIDesignable {
        self.view.tintColor = color
        
        return self
    }
}
