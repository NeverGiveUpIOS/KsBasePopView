//
//  KsUpwardAnimator.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

open class KsUpwardAnimator: KsBaseAnimator {
    
    open override func setup(popupView: KsPopupView, contentView: UIView, backgroundView: KsPopupView.BackgroundView) {
        super.setup(popupView: popupView, contentView: contentView, backgroundView: backgroundView)
        
        // Set initial state for upward animation
        let fromClosure = { [weak self, weak popupView] in
            guard let self = self, let popupView = popupView else { return }
            backgroundView.alpha = 0
            
            switch self.layout {
            case .frame(var frame):
                frame.origin.y = popupView.frame.size.height
                contentView.frame = frame
            case .center, .leading, .trailing:
                var contentViewHeight = contentView.heightConstraint(firstItem: contentView)?.constant
                if contentViewHeight == nil {
                    contentViewHeight = contentView.intrinsicContentSize.height
                }
                popupView.centerYConstraint(firstItem: contentView)?.constant =
                (popupView.bounds.size.height/2 + contentViewHeight!/2)
                popupView.layoutIfNeeded()
            case .top:
                self.dismissAnimationOptions = .transitionCurlDown
                popupView.topConstraint(firstItem: contentView)?.constant = popupView.bounds.size.height
                popupView.layoutIfNeeded()
            case .bottom:
                self.dismissAnimationOptions = .transitionCurlUp
                var contentViewHeight = contentView.heightConstraint(firstItem: contentView)?.constant
                if contentViewHeight == nil {
                    contentViewHeight = contentView.intrinsicContentSize.height
                }
                popupView.bottomConstraint(firstItem: contentView)?.constant = contentViewHeight!
                popupView.layoutIfNeeded()
            }
        }
        fromClosure()
        
        // Configure animation blocks
        displayAnimationBlock = { [weak self, weak popupView] in
            guard let self = self, let popupView = popupView else { return }
            backgroundView.alpha = 1
            
            switch self.layout {
            case .frame(let frame):
                contentView.frame = frame
            case .center, .leading, .trailing:
                popupView.centerYConstraint(firstItem: contentView)?.constant = self.layout.offsetY()
                popupView.layoutIfNeeded()
            case .top(let top):
                popupView.topConstraint(firstItem: contentView)?.constant = top.topMargin
                popupView.layoutIfNeeded()
            case .bottom(let bottom):
                popupView.bottomConstraint(firstItem: contentView)?.constant = -bottom.bottomMargin
                popupView.layoutIfNeeded()
            }
        }
        
        dismissAnimationBlock = {
            fromClosure()
        }
    }
}
