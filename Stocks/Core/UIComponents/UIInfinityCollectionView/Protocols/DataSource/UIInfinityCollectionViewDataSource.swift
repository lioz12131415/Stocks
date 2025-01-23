//
//  UIInfinityCollectionViewDataSource.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UIInfinityCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard count > 0 else {
            return UIInfinityEmptyCell.new(collectionView, for: indexPath)
        }
        return infinityDataSource?.collectionView(self, prepareCellAt: indexPathForCell(at: indexPath)) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = infinityDataSource?.collectionView(self, numberOfItemsInSection: section) else {
            return .zero
        }
        guard numberOfItems > 0 else {
            return .zero
        }
        let width      = Int(UIScreen.main.bounds.width)
        let multiplier = 3 * width / numberOfItems
        let itemsCount = numberOfItems > width ? (numberOfItems*3) : (numberOfItems*multiplier)
        return itemsCount
    }
}

@objc
protocol UIInfinityCollectionViewDataSource {
    func collectionView(_ collectionView: UIInfinityCollectionView, numberOfItemsInSection section: Int) -> Int
    
    func collectionView(_ collectionView: UIInfinityCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    func collectionView(_ collectionView: UIInfinityCollectionView, prepareCellAt indexPath: IndexPath) -> UICollectionViewCell
}


