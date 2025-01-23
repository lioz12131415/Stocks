//
//  UIInfinityCollectionView+Extentions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UIInfinityCollectionView {
    internal func indexPathForCell(at indexPath: IndexPath) -> IndexPath {
        guard count > 0 else {
            return .zero
        }
        return IndexPath(item: indexPath.item % count, section: .zero)
    }
}

extension UIInfinityCollectionView {
    internal func xOffset(for scrollView: UIScrollView) -> CGFloat {
        guard let interitemSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing else {
            return .zero
        }

        guard count > 0 else {
            return .zero
        }

        let width        = visibleSize.width
        let multiplier   = Int(size.width > width ? 2 : (3 * width) / size.width)
        
        let smaller_size = size.width + CGFloat(count) * interitemSpacing
        let bigger_size  = size.width * CGFloat(multiplier) + CGFloat(count * multiplier) * interitemSpacing
        
        if scrollView.contentOffset.x <= 0 {
            return smaller_size
        }
        
        if (scrollView.contentOffset.x) >= bigger_size {
            return smaller_size
        }
        
        return scrollView.contentOffset.x
    }
}
