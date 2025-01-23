//
//  SearchBarScrollsContainerSceneObserver.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class SearchBarScrollsContainerSceneObserver: NSObject, SearchBarScrollsContainerSceneObserve {

    fileprivate var didScrollBlock: ((UIScrollView) -> Void)?

    internal func didScroll(_ scrollView: UIScrollView) {
        self.didScrollBlock?(scrollView)
    }

    internal func didScroll(_ block: @escaping(UIScrollView) -> Void) {
        self.didScrollBlock = block
    }
}

protocol SearchBarScrollsContainerSceneObserve {
    func didScroll(_ block: @escaping(UIScrollView) -> Void)
}
