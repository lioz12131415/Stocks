//
//  UIInfinityCollectionViewSize.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

struct UIInfinityCollectionViewSize {
    
    private(set) var count: Int     = .zero
    private(set) var width: CGFloat = .zero
    private(set) var cache: [IndexPath: CGSize] = [:]
    
    internal mutating func update(_ collection: UIInfinityCollectionView,
                                  _ dataSource: UIInfinityCollectionViewDataSource?) {
        guard let numberOfItems = dataSource?.collectionView(collection, numberOfItemsInSection: .zero) else {
            return
        }
        guard numberOfItems > 0 else {
            return
        }
        width = 0
        cache = [:]
        for i in 0..<numberOfItems {
            let size  = dataSource?.collectionView(collection, sizeForItemAt: .init(row: i))
            let index = collection.indexPathForCell(at: .init(row: i))
            
            if let size = size, cache[index] == nil {
                cache[index] = size
            }
            width += size?.width ?? .zero
        }
    }
}
