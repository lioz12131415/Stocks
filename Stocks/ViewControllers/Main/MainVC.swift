//
//  MainVC.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class MainVC: UIViewController {

    @IBOutlet weak var bottomView:    UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* * * * * */
    }
    
    @IBAction func logoTouch(_ sender: UIButton) {
        UIApplication.open("https://finance.yahoo.com")
    }
}
