//
//  Register1.swift
//  QZ
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
class Register1: UIViewController {
    
    @IBOutlet weak var getVerBtn: UIButton!
    @IBOutlet weak  var verifyCode: UITextField!
    @IBOutlet weak var tellPhone: UITextField!
    let registerfunction = RegisterFunc.init()
    static var verify = String()
    static var tell = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        tellPhone.keyboardType = UIKeyboardType.NumberPad
        setNextBtton()
       
        
        
    }
    
    func setNextBtton()
    {
        let NextBtnItm = UIBarButtonItem.init(title: "下一步", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.nextFunction))
        self.navigationItem.rightBarButtonItem = NextBtnItm
       
    }
    func nextFunction()
    {
        if(tellPhone.text?.characters.count < 11 || tellPhone.text?.characters.count > 11)
        {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "输入不符合规范，请检查"
            hud.color = UIColor.whiteColor()
            hud.alpha = 0.7
            hud.labelColor = UIColor.lightGrayColor()
            hud.xOffset = 0
            hud.yOffset = 0
            hud.hide(true, afterDelay: 2)
        }else if(verifyCode.text?.characters.count == 0)
        {   let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入验证码"
            hud.color = UIColor.whiteColor()
            hud.alpha = 0.7
            hud.labelColor = UIColor.lightGrayColor()
            hud.xOffset = 0
            hud.yOffset = 0
            hud.hide(true, afterDelay: 2)
            
        }else
        {
            
        Register1.verify = verifyCode.text!
        Register1.tell = tellPhone.text!
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("register2")
self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
    }
    
    @IBAction func getVerifyCode()
    {
       if(tellPhone.text?.characters.count < 11 || tellPhone.text?.characters.count > 11)
       {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = "请输入正确的手机号码"
        hud.color = UIColor.whiteColor()
        hud.alpha = 0.7
        hud.labelColor = UIColor.lightGrayColor()
        hud.xOffset = 0
        hud.yOffset = 0
        hud.hide(true, afterDelay: 2)
        }else
       {
        registerfunction.getCheckNumber(tellPhone)
        }
        
    }
    
}
