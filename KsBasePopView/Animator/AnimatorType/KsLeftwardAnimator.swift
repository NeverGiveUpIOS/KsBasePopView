//
//  KsLeftwardAnimator.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

open class KsLeftwardAnimator: KsBaseAnimator {
    
    open override func setup(popupView: KsPopupView, contentView: UIView, backgroundView: KsPopupView.BackgroundView) {
        super.setup(popupView: popupView, contentView: contentView, backgroundView: backgroundView)
        
        let fromClosure = { [weak self, weak popupView] in
            guard let self = self, let popupView = popupView else { return }
            backgroundView.alpha = 0
            
            switch self.layout {
            case .frame(var frame):
                frame.origin.x = popupView.bounds.size.width
                contentView.frame = frame
            case .center, .top, .bottom:
                popupView.centerXConstraint(firstItem: contentView)?.constant =
                (popupView.bounds.size.width/2 + contentView.bounds.size.width/2)
                popupView.layoutIfNeeded()
            case .leading:
                popupView.leadingConstraint(firstItem: contentView)?.constant = popupView.bounds.size.width
                popupView.layoutIfNeeded()
            case .trailing:
                popupView.trailingConstraint(firstItem: contentView)?.constant = popupView.bounds.size.width
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
            case .center, .top, .bottom:
                popupView.centerXConstraint(firstItem: contentView)?.constant = self.layout.offsetX()
                popupView.layoutIfNeeded()
            case .leading(let leading):
                popupView.leadingConstraint(firstItem: contentView)?.constant = leading.leadingMargin
                popupView.layoutIfNeeded()
            case .trailing(let trailing):
                popupView.trailingConstraint(firstItem: contentView)?.constant = -trailing.trailingMargin
                popupView.layoutIfNeeded()
            }
        }
        
        dismissAnimationBlock = {
            fromClosure()
        }
    }
    
}
