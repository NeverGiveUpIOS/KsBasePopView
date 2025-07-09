//
//  KsZoomInOutAnimator.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

open class KsZoomInOutAnimator: KsBaseAnimator {
    
    open override func setup(popupView: KsPopupView, contentView: UIView, backgroundView: KsPopupView.BackgroundView) {
        super.setup(popupView: popupView, contentView: contentView, backgroundView: backgroundView)
        
        // Set initial state for zoom animation
        contentView.alpha = 0
        backgroundView.alpha = 0
        contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        // Configure animation blocks
        displayAnimationBlock = {
            contentView.alpha = 1
            contentView.transform = .identity
            backgroundView.alpha = 1
        }
        
        dismissAnimationBlock = {
            contentView.alpha = 0
            contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            backgroundView.alpha = 0
        }
    }
}
