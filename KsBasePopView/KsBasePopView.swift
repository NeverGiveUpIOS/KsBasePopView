//
//  KsBasePopView.swift
//  SwiftPopView
//
//  Created by cks on 2025/7/9.
// 使用方法， 继承： KsBasePopView， 可自动布局和设置frame

import UIKit

/// 弹窗位置
enum AlertContainerType {
    case curView
    case window
}

class KsBasePopView: UIView {
    
    /// 点击是否消失
    var isDismissible = true
    /// 被景色
    var bagColor = UIColor.black.withAlphaComponent(0.3)
    /// currentPopup
    private weak var currentPopup: KsPopupView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    /// 获取添加副视图
    private func getContainerView(_ type: AlertContainerType) -> UIView? {
        switch type {
        case .window:
            if #available(iOS 15.0, *) {
                return UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first?.windows
                    .first(where: \.isKeyWindow)
            } else {
                return UIApplication.shared.windows.first(where: \.isKeyWindow)
            }
        case .curView:
            return self.superview  // 一般是当前topView
        }
    }
    
    /// 构建 KsPopupView
    func buildPopup(_ containerView: UIView, _ animator: KsPopupVAnimator){
        // 2. 创建弹窗
        let popup = KsPopupView(
            containerView: containerView,
            contentView: self,
            animator: animator
        )
        popup.isDismissible = isDismissible
        popup.backgroundView.color = bagColor
        popup.didDismissCallback = { [weak self] in
            self?.removeFromSuperview()
        }
        self.currentPopup = popup  // 弱引用持有
        popup.display(animated: true)
    }
    
    /// 自定义消失方法
    func dismissView() {
        currentPopup?.dismiss()
        removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("KsBasePopView==========deinit")
        currentPopup?.dismiss()
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
    
}


// MARK: - Show
extension KsBasePopView {
    
    /// 显示中心
    func showCenter(containerType: AlertContainerType = .window,
                    isFadeIn: Bool = true) {
        // 安全获取窗口
        guard let containerView = getContainerView(containerType) else {
            return
        }
        buildPopup(containerView, isFadeIn ? KsFadeInOutAnimator() : KsZoomInOutAnimator())
    }
    
    /// 显示 左出现 leadingMargin: 左边间距
    func showLef(containerType: AlertContainerType = .window,
                 leadingMargin: CGFloat = 0) {
        // 安全获取窗口
        guard let containerView = getContainerView(containerType) else {
            return
        }
        
        let margin = UIScreen.main.bounds.width - self.frame.size.width + leadingMargin
        let layout = KsLeftwardAnimator.Layout.leading(.init(leadingMargin: margin))
        buildPopup(containerView, KsLeftwardAnimator(layout: layout))
    }
    
    /// 显示 右出现 trailingMargin: 右边间距
    func showRight(containerType: AlertContainerType = .window,
                   trailingMargin: CGFloat = 0) {
        // 安全获取窗口
        guard let containerView = getContainerView(containerType) else {
            return
        }
        
        let margin = UIScreen.main.bounds.width - self.frame.size.width + trailingMargin
        let layout = KsRighttwardAnimator.Layout.trailing(.init(trailingMargin: margin))
        buildPopup(containerView, KsRighttwardAnimator(layout: layout))
    }
    
    /// 显示 下拉出现 topMargin: 顶部间距
    func showDown(containerType: AlertContainerType = .window,
                  topMargin: CGFloat = 0) {
        // 安全获取窗口
        guard let containerView = getContainerView(containerType) else {
            return
        }
        
        let layout = KsDownwardAnimator.Layout.top(.init(topMargin: topMargin))
        buildPopup(containerView, KsDownwardAnimator(layout: layout))
    }
    
    /// 显示 上拉出现 bottomMargin：底部间距
    func showUp(containerType: AlertContainerType = .window,
                bottomMargin: CGFloat = 0) {
        // 安全获取窗口
        guard let containerView = getContainerView(containerType) else {
            return
        }
        
        let layout = KsUpwardAnimator.Layout.bottom(.init(bottomMargin: bottomMargin))
        buildPopup(containerView, KsUpwardAnimator(layout: layout))
    }
    
}
