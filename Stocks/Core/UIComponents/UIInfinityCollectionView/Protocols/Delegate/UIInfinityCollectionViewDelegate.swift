//
//  UIInfinityCollectionViewDelegate.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UIInfinityCollectionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset = CGPoint(x: xOffset(for: scrollView), y: .zero)
        infinityDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        infinityDelegate?.collectionView?(self, didSelect: cell, at: indexPathForCell(at: indexPath))
    }
}

@objc
protocol UIInfinityCollectionViewDelegate {
    @objc
    optional func scrollViewDidScroll(_ scrollView: UIScrollView)
    
    @objc
    optional func collectionView(_ collectionView: UIInfinityCollectionView,
                                 didSelect cell: UICollectionViewCell, at indexPath: IndexPath)
}

