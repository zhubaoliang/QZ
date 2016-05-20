//
//  RegisterFunc.swift
//  QZ
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class RegisterFunc {
    
    func userRegister(Phone:String,Password:UITextField,Code:String,target:UIViewController)
    {
        
         MBProgressHUD.showHUDAddedTo(target.view, animated: true)
        
        let url = appurl + "AppRegister"
        let param = ["phone":Phone,"password":Password.text!,"code":Code,"devicestate":"2","token":token]
        Alamofire.request(.GET, url, parameters: param).response{
            request, response, json, error in
            if(error != nil)
            {
                
            }else
            {
                
                let result = RegisterList.init(JSONDecoder(json!))
                print("状态")
                print(result.status)
                
                
                if (result.status != "error")
                {
                    let error = EMClient.sharedClient().registerWithUsername("qiezi" + (result.data?.id)!, password: result.data?.id)
                    if(error == nil)
                    {
                    print("用户id 为")
                    print(result.data)
                        MBProgressHUD.hideHUDForView(target.view, animated: true)
                        let revealController:SWRevealViewController = target.revealViewController()
                        
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let VC = mainStoryboard.instantiateViewControllerWithIdentifier("MainView")
                        revealController.pushFrontViewController(VC, animated: true)
                    }else{
                        MBProgressHUD.hideHUDForView(target.view, animated: true)
                        let hud = MBProgressHUD.showHUDAddedTo(target.view, animated: true)
                        hud.mode = MBProgressHUDMode.Text
                        hud.labelText = "注册失败"
                        hud.color = UIColor.whiteColor()
                        hud.alpha = 0.7
                        hud.labelColor = UIColor.lightGrayColor()
                        hud.xOffset = 0
                        hud.yOffset = 0
                        hud.hide(true, afterDelay: 2)
                        
                    }
                }else
                {
                    MBProgressHUD.hideHUDForView(target.view, animated: true)
                    let hud = MBProgressHUD.showHUDAddedTo(target.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = "注册失败"
                    hud.color = UIColor.whiteColor()
                    hud.alpha = 0.7
                    hud.labelColor = UIColor.lightGrayColor()
                    hud.xOffset = 0
                    hud.yOffset = 0
                    hud.hide(true, afterDelay: 2)
                }
            }
            
            
            
        }
        
        
    }
    
    func getCheckNumber(Phone:UITextField)
    {
        let url = appurl + "SendMobileCode"
        let param = ["phone":Phone.text!]
        Alamofire.request(.GET, url, parameters: param ).response{
            request, response, json, error in
            
            if(error == nil)
            {
                print("==========================================")
                print("send request for phoneCheckNumber success")
                print("==========================================")
            }else
            {
                print("==========================================")
                print("send request for phoneCheckNumber faild")
                print("==========================================")
                
            }
            
        }
    }
}
