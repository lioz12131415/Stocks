//
//  SearchBarFieldContainerSceneObserver.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final class SearchBarFieldContainerSceneObserver: NSObject, SearchBarFieldContainerSceneObserve {

    fileprivate var endEditingBlock:    (() -> Void)?
    fileprivate var beginEditingBlock:  (() -> Void)?
    fileprivate var buttonClickedBlock: (() -> Void)?
    fileprivate var textDidChangeBlock: ((String) -> Void)?

    internal func endEditing() {
        self.endEditingBlock?()
    }

    internal func beginEditing() {
        self.beginEditingBlock?()
    }

    internal func buttonClicked() {
        self.buttonClickedBlock?()
    }
    
    internal func textDidChange(_ searchText: String) {
        self.textDidChangeBlock?(searchText)
    }

    internal func endEditing(_ block: @escaping() -> Void) {
        self.endEditingBlock = block
    }

    internal func beginEditing(_ block: @escaping() -> Void) {
        self.beginEditingBlock = block
    }

    internal func buttonClicked(_ block: @escaping() -> Void) {
        self.buttonClickedBlock = block
    }
    
    internal func textDidChange(_ block: @escaping(String) -> Void) {
        self.textDidChangeBlock = block
    }
}

protocol SearchBarFieldContainerSceneObserve {
    func endEditing(_ block: @escaping() -> Void)
    func beginEditing(_ block: @escaping() -> Void)
    func buttonClicked(_ block: @escaping() -> Void)
    func textDidChange(_ block: @escaping(String) -> Void)
}
