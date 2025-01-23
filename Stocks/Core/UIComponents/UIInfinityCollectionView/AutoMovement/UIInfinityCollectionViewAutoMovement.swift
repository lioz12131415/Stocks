//
//  UIInfinityCollectionViewAutoMovement.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final class UIInfinityCollectionViewAutoMovement {
    
    fileprivate /**/ var timer:          Timer?                    = nil
    fileprivate weak var collectionView: UIInfinityCollectionView? = nil
    
    init(_ collectionView: UIInfinityCollectionView) {
        self.collectionView = collectionView
    }
        
    internal func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    internal func start() {
        self.stop()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.010, repeats: true) { [weak self] timer in
            self?.collectionView?.contentOffset.x -= 0.2
        }
    }
    
    deinit {
        stop()
    }
}
