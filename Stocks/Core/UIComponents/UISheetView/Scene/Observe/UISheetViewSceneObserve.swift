//
//  UISheetViewSceneObserve.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

protocol UISheetViewSceneObserve {
    
    typealias Detent     = UISheetDetent
    typealias Visability = UISheetView.Visability
    
    @discardableResult
    func didChange(_ block: @escaping(_ progress: CGFloat) -> Void) -> Self
    @discardableResult
    func didSetDetent(_ block: @escaping(_ newValue: Detent) -> Void) -> Self
    @discardableResult
    func willSetDetent(_ block: @escaping(_ newValue: Detent) -> Void) -> Self
    @discardableResult
    func didSetVisability(_ block: @escaping(_ newValue: Visability) -> Void) -> Self
    @discardableResult
    func willSetVisability(_ block: @escaping(_ newValue: Visability) -> Void) -> Self
    

    @discardableResult
    func didSetDetent(_ block: @escaping(_ newValue: Detent,
                                         _ oldValue: Detent) -> Void) -> Self
    @discardableResult
    func willSetDetent(_ block: @escaping(_ newValue: Detent,
                                          _ oldValue: Detent) -> Void) -> Self
    @discardableResult
    func didSetVisability(_ block: @escaping(_ newValue: Visability, 
                                             _ oldValue: Visability) -> Void) -> Self
    @discardableResult
    func willSetVisability(_ block: @escaping(_ newValue: Visability, 
                                              _ oldValue: Visability) -> Void) -> Self
}
