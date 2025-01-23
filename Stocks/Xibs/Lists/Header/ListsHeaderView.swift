//
//  ListsHeaderView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class ListsHeaderView: UISearchBarHeaderView {
    
    private(set) lazy var titleView: ListsHeaderTitleView = {
        return ListsHeaderTitleView.loadFromNib()
    }()
    
    private(set) lazy var chartsCollectionView: ListsHeaderChartsCollectionView = {
        return ListsHeaderChartsCollectionView.loadFromNib()
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.add(to: self)
        self.chartsCollectionView.add(to: self, sendToBack: true)
        
        self.chartsCollectionView.alpha = 0.0
        self.bringSubviewToFront(chartsCollectionView)
    }
}

