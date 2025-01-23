//
//  UISearchBarControllerScenes.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

class UISearchBarControllerScenes: NSObject {
    
    private(set) weak var fieldContainer:     SearchBarFieldContainerSceneAccessible?
    private(set) weak var scrollsContainer:   SearchBarScrollsContainerSceneAccessible?
    private(set) weak var pageViewController: SearchBarPageViewControllerSceneAccessible?
    
    internal func set(scene: SearchBarFieldContainerScene) {
        self.fieldContainer = scene
    }

    internal func set(scene: SearchBarScrollsContainerScene) {
        self.scrollsContainer = scene
    }
    
    internal func set(scene: SearchBarPageViewControllerScene) {
        self.pageViewController = scene
    }
}

