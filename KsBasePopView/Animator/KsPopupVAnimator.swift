//
//  KsPopupVAnimator.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

/// Protocol defining the animation behavior for popup views
public protocol KsPopupVAnimator {
    
    /// Setup the animator with required views
    /// - Parameters:
    ///   - popupView: The container popup view
    ///   - contentView: The custom content view to be displayed
    ///   - backgroundView: The background view of the popup
    func setup(popupView: KsPopupView, contentView: UIView, backgroundView: KsPopupView.BackgroundView)
    
    /// Refresh layout when device orientation changes
    /// - Parameters:
    ///   - popupView: The container popup view
    ///   - contentView: The custom content view
    func refreshLayout(popupView: KsPopupView, contentView: UIView)
    
    /// Handle display animation
    /// - Parameters:
    ///   - contentView: The custom content view
    ///   - backgroundView: The background view
    ///   - animated: Whether animation should be performed
    ///   - completion: Completion handler when animation finishes
    func display(contentView: UIView, backgroundView: KsPopupView.BackgroundView, animated: Bool, completion: @escaping ()->())
    
    /// Handle dismiss animation
    /// - Parameters:
    ///   - contentView: The custom content view
    ///   - backgroundView: The background view
    ///   - animated: Whether animation should be performed
    ///   - completion: Completion handler when animation finishes
    func dismiss(contentView: UIView, backgroundView: KsPopupView.BackgroundView, animated: Bool, completion: @escaping ()->())
}
