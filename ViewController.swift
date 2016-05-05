//
//  ViewController.swift
//  QZ
//
//  Created by ios on 16/5/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        let revealController:SWRevealViewController = self.revealViewController()
        self.navigationController?.navigationBar.addGestureRecognizer(revealController.panGestureRecognizer())
    }
    
    


}

