//
//  HomeWaterfallLayout.swift
//  cazycatClient
//
//  Created by yy on 2025/4/2.
//

import UIKit

protocol KsWaterfallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView,
                        sizeForHeaderInSection section: Int) -> CGSize
}

class KsWaterfallLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns = 2
      var cellPadding: CGFloat = 8
      weak var delegate: KsWaterfallLayoutDelegate?
      
      private var cache: [UICollectionViewLayoutAttributes] = []
      private var headerAttributes: UICollectionViewLayoutAttributes?
      private var contentHeight: CGFloat = 0
      private var contentWidth: CGFloat {
          guard let collectionView = collectionView else { return 0 }
          return collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
      }
      
      override var collectionViewContentSize: CGSize {
          return CGSize(width: contentWidth, height: contentHeight)
      }
      
      override func prepare() {
          guard let collectionView = collectionView else { return }
          
          cache.removeAll()
          contentHeight = 0
          
          // 计算 Header
          let headerSize = delegate?.collectionView(collectionView, sizeForHeaderInSection: 0) ?? .zero
          if headerSize.height > 0 {
              let attributes = UICollectionViewLayoutAttributes(
                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                  with: IndexPath(item: 0, section: 0)
              )
              attributes.frame = CGRect(origin: .zero, size: headerSize)
              headerAttributes = attributes
              contentHeight = headerSize.height
          }
          
          // 计算列宽
          let columnWidth = (contentWidth - CGFloat(numberOfColumns - 1) * cellPadding) / CGFloat(numberOfColumns)
          var xOffset: [CGFloat] = (0..<numberOfColumns).map {
              CGFloat($0) * (columnWidth + cellPadding)
          }
          var yOffset = [CGFloat](repeating: contentHeight + cellPadding, count: numberOfColumns)
          
          // 计算所有 Cell
          for item in 0..<collectionView.numberOfItems(inSection: 0) {
              let indexPath = IndexPath(item: item, section: 0)
              let itemSize = delegate?.collectionView(collectionView, sizeForItemAt: indexPath) ?? .zero
              
              // 找到最短列
              let column = yOffset.enumerated().min { $0.element < $1.element }?.offset ?? 0
              let frame = CGRect(
                  x: xOffset[column],
                  y: yOffset[column],
                  width: columnWidth,
                  height: itemSize.height
              )
              
              let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
              attributes.frame = frame
              cache.append(attributes)
              
              contentHeight = max(contentHeight, frame.maxY)
              yOffset[column] = yOffset[column] + itemSize.height + cellPadding
          }
      }
      
      override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
          var visibleAttributes = [UICollectionViewLayoutAttributes]()
          if let header = headerAttributes, header.frame.intersects(rect) {
              visibleAttributes.append(header)
          }
          for attributes in cache where attributes.frame.intersects(rect) {
              visibleAttributes.append(attributes)
          }
          return visibleAttributes
      }
      
      override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
          cache.first { $0.indexPath == indexPath }
      }
      
      override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                        at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
          elementKind == UICollectionView.elementKindSectionHeader ? headerAttributes : nil
      }
      
      override func invalidateLayout() {
          super.invalidateLayout()
          cache.removeAll()
          headerAttributes = nil
          contentHeight = 0
      }
    
}
