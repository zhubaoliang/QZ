//
//  Tabcontroller.swift
//  QZ
//
//  Created by xiaocool on 16/5/5.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class Tabcontroller: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.view.backgroundColor = UIColor.blueColor()
        let revealController:SWRevealViewController = self.revealViewController()
        revealController.panGestureRecognizer()
        
            }
    
   
}
