//
//  Register2.swift
//  QZ
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
class Register2: UIViewController {
    @IBOutlet weak var finshedBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    let registerfunc = RegisterFunc.init()
    override func viewDidLoad() {
       
        super.viewDidLoad()
    }
    
  @IBAction func finishedBtnClicked()
    {
        finshedBtn.resignFirstResponder()
        rePassword.resignFirstResponder()
        if(password.text == rePassword.text)
        {
            
            registerfunc.userRegister(Register1.tell, Password: password, Code: Register1.verify,target:self)
        }else
        {
            
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入一致的密码"
            hud.color = UIColor.whiteColor()
            hud.alpha = 0.7
            hud.labelColor = UIColor.lightGrayColor()
            hud.xOffset = 0
            hud.yOffset = 0
            hud.hide(true, afterDelay: 2)
            
        }
        
    }
}
