//
//  UIInfinityCollectionViewEmptyCell.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UIInfinityEmptyCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.backgroundColor = .clear
    }
    
    internal static func new(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIInfinityEmptyCell", for: indexPath) as! UIInfinityEmptyCell
        return cell
    }
}
