//
//  UISearchBarHeaderContainerView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarHeaderContainerView: UIView {
    
    fileprivate weak var topConstraint:    NSLayoutConstraint? = nil
    fileprivate weak var leftConstraint:   NSLayoutConstraint? = nil
    fileprivate weak var rightConstraint:  NSLayoutConstraint? = nil
    fileprivate weak var widthConstraint:  NSLayoutConstraint? = nil
    fileprivate weak var heightConstraint: NSLayoutConstraint? = nil
    
    private(set) lazy var header: UISearchBarHeaderView?       = nil
    private(set) weak var scenes: UISearchBarControllerScenes? = nil
    
    fileprivate var height: CGFloat = .zero {
        didSet { }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.backgroundColor = .clear
    }

    internal func set(height: CGFloat) {
        self.height = height
        self.heightConstraint?.constant = height
    }
    
    internal func set(scenes: UISearchBarControllerScenes) {
        self.scenes = scenes
        self.scenes?.fieldContainer?.observe(self).endEditing   { [weak self] in self?.endEditing()   }
        self.scenes?.fieldContainer?.observe(self).beginEditing { [weak self] in self?.beginEditing() }
    }
    
    fileprivate func endEditing() {
        self.heightConstraint?.constant = height
        self.header?.add(to: self)
    }
    
    fileprivate func beginEditing() {
        self.heightConstraint?.constant = .zero
        self.header?.removeFromSuperview()
    }
}

extension UISearchBarHeaderContainerView {
    internal func loadFromNib(_ name: String) {
        subviews.filter { $0 is UISearchBarHeaderView }.forEach {
            $0.removeFromSuperview()
        }
        guard let view = UISearchBarHeaderView.nibView(nibName: name) else {
            return
        }
        view.add(to: self)
        header = view as? UISearchBarHeaderView
    }
}

extension UISearchBarHeaderContainerView {
    internal func add(to controller: UISearchBarController, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(self)
        
        topConstraint    = topAnchor.constraint(equalTo:   controller.view.safeAreaLayoutGuide.topAnchor)
        leftConstraint   = leftAnchor.constraint(equalTo:  controller.view.leftAnchor)
        rightConstraint  = rightAnchor.constraint(equalTo: controller.view.rightAnchor)
        widthConstraint  = widthAnchor.constraint(equalTo: controller.view.widthAnchor)
        heightConstraint = heightAnchor.constraint(equalToConstant: height)
        
        topConstraint?.isActive    = true
        leftConstraint?.isActive   = true
        rightConstraint?.isActive  = true
        widthConstraint?.isActive  = true
        heightConstraint?.isActive = true
    }
}

