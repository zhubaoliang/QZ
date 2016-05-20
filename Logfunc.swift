//
//  Logfunc.swift
//  QZ
//
//  Created by ios on 16/5/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class Loginfunc{
    let messageview  = UILabel.init()
    func checkUserMessageAndLogin(userField:UITextField,passWord:UITextField,target:UIViewController)
    {
        if(userField.text?.characters.count == 0)
        {
            let alertVC:UIAlertController = UIAlertController.init(title: "提示", message: "号码不能为空", preferredStyle: UIAlertControllerStyle.Alert)
            let alertButton:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler:{Void in })
            alertVC.addAction(alertButton)
            target.presentViewController(alertVC, animated: true, completion: nil)
        }else if(userField.text?.characters.count < 11 || userField.text?.characters.count > 11)
        {
            let alertVC:UIAlertController = UIAlertController.init(title: "提示", message: "号码不合法，请检查!!", preferredStyle: UIAlertControllerStyle.Alert)
            let alertButton:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler:{Void in })
            alertVC.addAction(alertButton)
            target.presentViewController(alertVC, animated: true, completion: nil)
        }else if(passWord.text?.characters.count == 0)
        {
            let alertVC:UIAlertController = UIAlertController.init(title: "提示", message: "密码不能为空", preferredStyle: UIAlertControllerStyle.Alert)
            let alertButton:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler:{Void in })
            alertVC.addAction(alertButton)
            target.presentViewController(alertVC, animated: true, completion: nil)
        }else
        {
            MBProgressHUD.showHUDAddedTo(target.view, animated: true)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), {
            print(userField.text)
            print(passWord.text)
            let url = appurl + "applogin"
            let para = ["phone":userField.text!,"password":passWord.text!,"token":"qiezi123"]
            Alamofire.request(.GET, url, parameters: para).response { request, response, json, error in
                if(error == nil){
                    print("request是")
                    print(request!)
                    print("response是")
                    print(response!)
                    print("data是")
                    print(json!)
                    print("====================")
                }
                else
                {
                    
                    
                }
                let result = Httpresult(JSONDecoder(json!))
                print("状态是")
                print(result.status)
                if(result.status != "success"){
                    print("登录失败")
                    let hud = MBProgressHUD.showHUDAddedTo(target.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = "登录失败"
                    hud.color = UIColor.whiteColor()
                    hud.alpha = 0.7
                    hud.labelColor = UIColor.lightGrayColor()
                    hud.xOffset = 0
                    hud.yOffset = 200
                    hud.hide(true, afterDelay: 2)
                    
                }
                if(result.status == "success"){
                    print("Success")
                    print(result.data)
                    
                    let userMessage:[String] = [userField.text!,passWord.text!,(result.data?.id)!]
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.setObject(userMessage, forKey: "userinfo")
                    userDefaults.synchronize()
                    //环信登录
                    let options = EMOptions.init(appkey: "xiaocool#qiezi")
                    EMClient.sharedClient().initializeSDKWithOptions(options)
                    let error = EMClient.sharedClient().loginWithUsername( "qiezi32" , password: "32")
                    if(error  == nil)
                    {
                        let hud = MBProgressHUD.showHUDAddedTo(target.view, animated: true)
                        hud.mode = MBProgressHUDMode.Text
                        hud.labelText = "登录成功"
                        hud.color = UIColor.whiteColor()
                        hud.alpha = 0.7
                        hud.labelColor = UIColor.lightGrayColor()
                        hud.xOffset = 0
                        hud.yOffset = 200
                        hud.hide(true, afterDelay: 2)
                        print("环信登录成功")
                        let revealController:SWRevealViewController = target.revealViewController()
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainView")
                        revealController.pushFrontViewController(vc, animated: true)
                        
                    }else{
                        print("环信登录失败")
                        userDefaults.removeObjectForKey("userinfo")
                        let hud = MBProgressHUD.showHUDAddedTo(target.view, animated: true)
                        hud.mode = MBProgressHUDMode.Text
                        hud.labelText = "登录失败"
                        hud.color = UIColor.whiteColor()
                        hud.alpha = 0.7
                        hud.labelColor = UIColor.lightGrayColor()
                        hud.xOffset = 0
                        hud.yOffset = 200
                        hud.hide(true, afterDelay: 2)
                        
                    }
                    
                    
                    
                   
                    
                    
                    
                    
                }
                
            }
                dispatch_async(dispatch_get_main_queue(), {
                    MBProgressHUD.hideHUDForView(target.view, animated: true)
                    
                })
                
            })
        }
    }
    
    

    
}
