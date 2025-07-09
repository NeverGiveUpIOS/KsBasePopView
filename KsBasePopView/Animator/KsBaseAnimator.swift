//
//  KsBaseAnimator.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

open class KsBaseAnimator: KsPopupVAnimator {
    
    /// The layout configuration for the popup view
    open var layout: Layout
    
    // MARK: - Display Animation Properties
    
    /// Duration for display animation
    open var displayDuration: TimeInterval = 0.25
    
    /// Options for display animation
    open var displayAnimationOptions: UIView.AnimationOptions = .curveEaseInOut
    
    /// Spring damping ratio for display animation (if using spring animation)
    open var displaySpringDampingRatio: CGFloat?
    
    /// Spring velocity for display animation (if using spring animation)
    open var displaySpringVelocity: CGFloat?
    
    /// Block containing display animation changes
    open var displayAnimationBlock: (()->())?
    
    // MARK: - Dismiss Animation Properties
    
    /// Duration for dismiss animation
    open var dismissDuration: TimeInterval = 0.25
    
    /// Options for dismiss animation
    open var dismissAnimationOptions: UIView.AnimationOptions = .curveEaseInOut
    
    /// Spring damping ratio for dismiss animation (if using spring animation)
    open var dismissSpringDampingRatio: CGFloat?
    
    /// Spring velocity for dismiss animation (if using spring animation)
    open var dismissSpringVelocity: CGFloat?
    
    /// Block containing dismiss animation changes
    open var dismissAnimationBlock: (()->())?
    
    // MARK: - Initialization
    
    /// Initialize with a layout configuration
    /// - Parameter layout: The layout configuration
    public init(layout: Layout = .center(.init())) {
        self.layout = layout
    }
    
    // MARK: - PopupViewAnimator
    
    open func setup(popupView: KsPopupView, contentView: UIView, backgroundView: KsPopupView.BackgroundView) {
        switch layout {
        case .center(let center):
            setupCenterLayout(popupView: popupView, contentView: contentView, center: center)
        case .top(let top):
            setupTopLayout(popupView: popupView, contentView: contentView, top: top)
        case .bottom(let bottom):
            setupBottomLayout(popupView: popupView, contentView: contentView, bottom: bottom)
        case .leading(let leading):
            setupLeadingLayout(popupView: popupView, contentView: contentView, leading: leading)
        case .trailing(let trailing):
            setupTrailingLayout(popupView: popupView, contentView: contentView, trailing: trailing)
        case .frame(let frame):
            contentView.frame = frame
        }
    }
    
    open func refreshLayout(popupView: KsPopupView, contentView: UIView) {
        if case .frame(let frame) = layout {
            contentView.frame = frame
        }
    }
    
    open func display(contentView: UIView, backgroundView: KsPopupView.BackgroundView, animated: Bool, completion: @escaping () -> ()) {
        guard !contentView.isHidden else {
            completion()
            return
        }
        
        if animated {
            let animations = { [weak self] in
                self?.displayAnimationBlock?() ?? ()
            }
            
            let completionHandler: (Bool) -> Void = { _ in
                completion()
            }
            
            if let displaySpringDampingRatio = displaySpringDampingRatio,
               let displaySpringVelocity = displaySpringVelocity {
                UIView.animate(
                    withDuration: displayDuration,
                    delay: 0,
                    usingSpringWithDamping: displaySpringDampingRatio,
                    initialSpringVelocity: displaySpringVelocity,
                    options: displayAnimationOptions,
                    animations: animations,
                    completion: completionHandler
                )
            } else {
                UIView.animate(
                    withDuration: displayDuration,
                    delay: 0,
                    options: displayAnimationOptions,
                    animations: animations,
                    completion: completionHandler
                )
            }
        } else {
            displayAnimationBlock?()
            completion()
        }
    }
    
    open func dismiss(contentView: UIView, backgroundView: KsPopupView.BackgroundView, animated: Bool, completion: @escaping () -> ()) {
        guard !contentView.isHidden else {
            completion()
            return
        }
        
        if animated {
            let animations = { [weak self] in
                self?.dismissAnimationBlock?() ?? ()
            }
            
            let completionHandler: (Bool) -> Void = { _ in
                completion()
            }
            
            if let dismissSpringDampingRatio = dismissSpringDampingRatio,
               let dismissSpringVelocity = dismissSpringVelocity {
                UIView.animate(
                    withDuration: dismissDuration,
                    delay: 0,
                    usingSpringWithDamping: dismissSpringDampingRatio,
                    initialSpringVelocity: dismissSpringVelocity,
                    options: dismissAnimationOptions,
                    animations: animations,
                    completion: completionHandler
                )
            } else {
                UIView.animate(
                    withDuration: dismissDuration,
                    delay: 0,
                    options: dismissAnimationOptions,
                    animations: animations,
                    completion: completionHandler
                )
            }
        } else {
            dismissAnimationBlock?()
            completion()
        }
    }
    
    // MARK: - Layout Helpers
    
    private func setupCenterLayout(popupView: KsPopupView, contentView: UIView, center: Layout.Center) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor, constant: center.offsetX).isActive = true
        contentView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor, constant: center.offsetY).isActive = true
        
        if let width = center.width {
            contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = center.height {
            contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func setupTopLayout(popupView: KsPopupView, contentView: UIView, top: Layout.Top) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: top.topMargin).isActive = true
        contentView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor, constant: top.offsetX).isActive = true
        
        if let width = top.width {
            contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = top.height {
            contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func setupBottomLayout(popupView: KsPopupView, contentView: UIView, bottom: Layout.Bottom) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -bottom.bottomMargin).isActive = true
        contentView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor, constant: bottom.offsetX).isActive = true
        
        if let width = bottom.width {
            contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = bottom.height {
            contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func setupLeadingLayout(popupView: KsPopupView, contentView: UIView, leading: Layout.Leading) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: leading.leadingMargin).isActive = true
        contentView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor, constant: leading.offsetY).isActive = true
        
        if let width = leading.width {
            contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = leading.height {
            contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func setupTrailingLayout(popupView: KsPopupView, contentView: UIView, trailing: Layout.Trailing) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -trailing.trailingMargin).isActive = true
        contentView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor, constant: trailing.offsetY).isActive = true
        
        if let width = trailing.width {
            contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = trailing.height {
            contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - Layout Definitions

extension KsBaseAnimator {
    
    /// Enum defining possible layout configurations for the popup view
    public enum Layout {
        case center(Center)
        case top(Top)
        case bottom(Bottom)
        case leading(Leading)
        case trailing(Trailing)
        case frame(CGRect)
        
        /// X-axis offset
        func offsetX() -> CGFloat {
            switch self {
            case .center(let center): return center.offsetX
            case .top(let top): return top.offsetX
            case .bottom(let bottom): return bottom.offsetX
            case .leading, .trailing, .frame: return 0
            }
        }
        
        /// Y-axis offset
        func offsetY() -> CGFloat {
            switch self {
            case .center(let center): return center.offsetY
            case .leading(let leading): return leading.offsetY
            case .trailing(let trailing): return trailing.offsetY
            case .top, .bottom, .frame: return 0
            }
        }
        
        /// Center layout configuration
        public struct Center {
            public var offsetY: CGFloat
            public var offsetX: CGFloat
            public var width: CGFloat?
            public var height: CGFloat?
            
            public init(offsetY: CGFloat = 0, offsetX: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
                self.offsetY = offsetY
                self.offsetX = offsetX
                self.width = width
                self.height = height
            }
        }
        
        /// Top layout configuration
        public struct Top {
            public var topMargin: CGFloat
            public var offsetX: CGFloat
            public var width: CGFloat?
            public var height: CGFloat?
            
            public init(topMargin: CGFloat = 0, offsetX: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
                self.topMargin = topMargin
                self.offsetX = offsetX
                self.width = width
                self.height = height
            }
        }
        
        /// Bottom layout configuration
        public struct Bottom {
            public var bottomMargin: CGFloat
            public var offsetX: CGFloat
            public var width: CGFloat?
            public var height: CGFloat?
            
            public init(bottomMargin: CGFloat = 0, offsetX: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
                self.bottomMargin = bottomMargin
                self.offsetX = offsetX
                self.width = width
                self.height = height
            }
        }
        
        /// Leading layout configuration
        public struct Leading {
            public var leadingMargin: CGFloat
            public var offsetY: CGFloat
            public var width: CGFloat?
            public var height: CGFloat?
            
            public init(leadingMargin: CGFloat = 0, offsetY: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
                self.leadingMargin = leadingMargin
                self.offsetY = offsetY
                self.width = width
                self.height = height
            }
        }
        
        /// Trailing layout configuration
        public struct Trailing {
            public var trailingMargin: CGFloat
            public var offsetY: CGFloat
            public var width: CGFloat?
            public var height: CGFloat?
            
            public init(trailingMargin: CGFloat = 0, offsetY: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
                self.trailingMargin = trailingMargin
                self.offsetY = offsetY
                self.width = width
                self.height = height
            }
        }
    }
}

// MARK: - UIView Constraint Helpers

extension UIView {
    func widthConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .width && $0.firstItem as? UIView == firstItem }
    }
    
    func heightConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .height && $0.firstItem as? UIView == firstItem }
    }
    
    func centerXConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .centerX && $0.firstItem as? UIView == firstItem }
    }
    
    func centerYConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .centerY && $0.firstItem as? UIView == firstItem }
    }
    
    func topConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .top && $0.firstItem as? UIView == firstItem }
    }
    
    func bottomConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .bottom && $0.firstItem as? UIView == firstItem }
    }
    
    func leadingConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .leading && $0.firstItem as? UIView == firstItem }
    }
    
    func trailingConstraint(firstItem: UIView) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == .trailing && $0.firstItem as? UIView == firstItem }
    }
}
