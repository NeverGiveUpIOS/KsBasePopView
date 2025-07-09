//
//  KsFadeInOutAnimator.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

open class KsFadeInOutAnimator: KsBaseAnimator {
    
    open override func setup(popupView: KsPopupView, contentView: UIView, backgroundView: KsPopupView.BackgroundView) {
        super.setup(popupView: popupView, contentView: contentView, backgroundView: backgroundView)
        
        // Set initial state for fade animation
        contentView.alpha = 0
        backgroundView.alpha = 0
        
        // Configure animation blocks
        displayAnimationBlock = {
            contentView.alpha = 1
            backgroundView.alpha = 1
        }
        
        dismissAnimationBlock = {
            contentView.alpha = 0
            backgroundView.alpha = 0
        }
    }
}
