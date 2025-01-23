//
//  UIInfinityCollectionView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UIInfinityCollectionView: UICollectionView {
    
    private(set) weak var _delegate:   UIInfinityCollectionViewDelegate?
    private(set) weak var _dataSource: UIInfinityCollectionViewDataSource?
    
    weak override var delegate: UICollectionViewDelegate? {
        set { } get { return super.delegate }
    }
    
    weak override var dataSource: UICollectionViewDataSource? {
        set { } get { return super.dataSource }
    }
    
    weak var infinityDelegate: UIInfinityCollectionViewDelegate? {
        get { return _delegate     }
        set { _delegate = newValue; didSetDelegate() }
    }
    
    weak var infinityDataSource: UIInfinityCollectionViewDataSource? {
        get { return _dataSource     }
        set { _dataSource = newValue; didSetDataSource() }
    }
    
    private(set) var count: Int = .zero
    
    private(set) lazy var size: UIInfinityCollectionViewSize = {
        return UIInfinityCollectionViewSize()
    }()
    
    private(set) lazy var movement: UIInfinityCollectionViewAutoMovement = {
        return UIInfinityCollectionViewAutoMovement(self)
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        super.register(UIInfinityEmptyCell.self, forCellWithReuseIdentifier: "UIInfinityEmptyCell")
        super.delegate   = self
        super.dataSource = self
    }
    
    override func reloadData() {
        self.count = _dataSource?.collectionView(self, numberOfItemsInSection: .zero) ?? .zero
        self.size.update(self, _dataSource)
        super.reloadData()
    }
    
    fileprivate func didSetDelegate() {
        /* Use if needed */
    }
    
    fileprivate func didSetDataSource() {
        /* Use if needed */
    }
}

extension UIInfinityCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let size = size.cache[indexPathForCell(at: indexPath)] else {
            return .zero
        }
        return size
    }
}
