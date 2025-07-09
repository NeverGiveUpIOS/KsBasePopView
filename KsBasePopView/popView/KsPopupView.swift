//
//  KsPopupView.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
//

import UIKit

public class KsPopupView: UIView {
    
    /// Enum defining the possible positions for the popup view
    public enum Position {
        case top
        case center
        case bottom
    }
    
    /*
     Configuration properties:
     - isDismissible: When true, tapping outside content (area B) will dismiss (if isPenetrable is false)
     - isInteractive: When true, taps on content (area A) will be handled by contentView
     - isPenetrable: When true, taps outside content will pass through to views below
     */
    
    /// Whether the popup can be dismissed by tapping outside content
    public var isDismissible = false {
        didSet {
            backgroundView.isUserInteractionEnabled = isDismissible
        }
    }
    
    /// Whether the content view should handle user interactions
    public var isInteractive = true
    
    /// Whether touches outside content should pass through to underlying views
    public var isPenetrable = false
    
    /// Current presentation state
    public private(set) var isPresenting = false
    
    /// The background view
    public let backgroundView: BackgroundView
    
    /// Callbacks for presentation/dismissal lifecycle
    public var willDisplayCallback: (()->())?
    public var didDisplayCallback: (()->())?
    public var willDismissCallback: (()->())?
    public var didDismissCallback: (()->())?
    
    private unowned let containerView: UIView
    private let contentView: UIView
    private let animator: KsPopupVAnimator
    private var isAnimating = false
    
    private var contentFrame = CGRect.zero
    var position: Position?
    private var keyboardObservers = [NSObjectProtocol]()
    /// Designated initializer
    /// - Parameters:
    ///   - containerView: The view to contain the popup (window, view controller's view, etc.)
    ///   - contentView: The custom content view to display
    ///   - animator: The animator conforming to KsPopupVAnimator protocol
    public init(containerView: UIView, contentView: UIView, animator: KsPopupVAnimator = KsFadeInOutAnimator()) {
        self.containerView = containerView
        self.contentView = contentView
        self.animator = animator
        self.backgroundView = BackgroundView(frame: containerView.bounds)
        
        super.init(frame: containerView.bounds)
        
        setupViews()
        setupKeyboardObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        backgroundView.isUserInteractionEnabled = isDismissible
        backgroundView.addTarget(self, action: #selector(backgroundViewClicked), for: .touchUpInside)
        addSubview(backgroundView)
        addSubview(contentView)
        
        animator.setup(popupView: self, contentView: contentView, backgroundView: backgroundView)
    }
    
    // MARK: - Keyboard Handling
    
    private func setupKeyboardObservers() {
        guard position != .top else { return }
        
        removeKeyboardObservers()
        
        let showObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.handleKeyboardShow(notification)
        }
        
        let hideObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.handleKeyboardHide(notification)
        }
        
        keyboardObservers = [showObserver, hideObserver]
    }
    
    private func removeKeyboardObservers() {
        keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
        keyboardObservers.removeAll()
    }
    
    @objc private func handleKeyboardShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
              let curve = UIView.AnimationCurve(rawValue: curveValue) else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: UInt(curve.rawValue) << 16)
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            guard let self = self else { return }
            
            if self.position == .bottom {
                let safeAreaBottom = self.safeAreaInsets.bottom
                let bottomY = self.bounds.height - self.contentFrame.height - keyboardHeight + safeAreaBottom
                self.contentView.frame.origin.y = bottomY
            } else if self.contentFrame.height < self.bounds.height / 3 {
                let centerY = (self.bounds.height - keyboardHeight) / 2 - self.contentFrame.height / 2
                self.contentView.frame.origin.y = centerY
            }
        })
    }
    
    @objc private func handleKeyboardHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
              let curve = UIView.AnimationCurve(rawValue: curveValue) else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: UInt(curve.rawValue) << 16)
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            guard let self = self else { return }
            
            if self.position == .bottom {
                let bottomY = self.bounds.height - self.contentFrame.height
                self.contentView.frame.origin.y = bottomY
            } else if self.contentFrame.height < self.bounds.height / 3 {
                let centerY = (self.bounds.height - self.contentFrame.height) / 2
                self.contentView.frame.origin.y = centerY
            }
        })
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        contentFrame = contentView.frame
        backgroundView.frame = bounds
        
        animator.refreshLayout(popupView: self, contentView: contentView)
    }
    
    // MARK: - Hit Testing
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let pointInContent = convert(point, to: contentView)
        let isPointInContent = contentView.bounds.contains(pointInContent)
        
        if isPointInContent {
            return isInteractive ? super.hitTest(point, with: event) : nil
        } else {
            return !isPenetrable ? super.hitTest(point, with: event) : nil
        }
    }
    
    // MARK: - Presentation
    
    /// Display the popup view
    /// - Parameters:
    ///   - animated: Whether to animate the presentation
    ///   - completion: Completion handler when presentation finishes
    public func display(animated: Bool, completion: (()->())? = nil) {
        guard !isAnimating else { return }
        
        isPresenting = true
        isAnimating = true
        
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: containerView.topAnchor),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        willDisplayCallback?()
        animator.display(contentView: contentView, backgroundView: backgroundView, animated: animated) { [weak self] in
            guard let self = self else { return }
            
            self.isAnimating = false
            completion?()
            self.didDisplayCallback?()
        }
    }
    
    /// Dismiss the popup view
    /// - Parameters:
    ///   - animated: Whether to animate the dismissal
    ///   - completion: Completion handler when dismissal finishes
    public func dismiss(animated: Bool = true, completion: (()->())? = nil) {
        guard !isAnimating else { return }
        
        isAnimating = true
        willDismissCallback?()
        
        animator.dismiss(contentView: contentView, backgroundView: backgroundView, animated: animated) { [weak self] in
            guard let self = self else { return }
            
            self.isPresenting = false
            self.contentView.removeFromSuperview()
            self.removeFromSuperview()
            
            self.isAnimating = false
            completion?()
            self.didDismissCallback?()
        }
    }
    
    @objc private func backgroundViewClicked() {
        dismiss(animated: true)
    }
}

// MARK: - Background View

extension KsPopupView {
    
    /// The background view for the popup
    public class BackgroundView: UIControl {
        
        /// The style of the background
        public enum BackgroundStyle {
            case solidColor
            case blur
        }
        
        /// The current background style
        public var style = BackgroundStyle.solidColor {
            didSet {
                refreshBackgroundStyle()
            }
        }
        
        /// The blur effect style (when style is .blur)
        public var blurEffectStyle = UIBlurEffect.Style.dark {
            didSet {
                refreshBackgroundStyle()
            }
        }
        
        /// The background color (applies to both styles)
        public var color = UIColor.black.withAlphaComponent(0.3) {
            didSet {
                backgroundColor = color
            }
        }
        
        private var effectView: UIVisualEffectView?
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            refreshBackgroundStyle()
            backgroundColor = color
            layer.allowsGroupOpacity = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, with: event)
            return view == effectView ? self : view
        }
        
        private func refreshBackgroundStyle() {
            effectView?.removeFromSuperview()
            effectView = nil
            
            if style == .blur {
                effectView = UIVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle))
                effectView?.frame = bounds
                addSubview(effectView!)
            }
        }
    }
}

// MARK: - UIView Extension

public extension UIView {
    /// Get the popup view containing this view if it exists
    func popupView() -> KsPopupView? {
        if let superview = self.superview, superview.isKind(of: KsPopupView.self) {
            return superview as? KsPopupView
        }
        return nil
    }
}
