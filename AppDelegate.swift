//
//  AppDelegate.swift
//  QZ
//
//  Created by ios on 16/5/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,EMClientDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
       
        //let LeftView = LeftViewcontroller()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainView")
        let LeftView = mainStoryboard.instantiateViewControllerWithIdentifier("leftview")
        let revealController = SWRevealViewController.init(rearViewController: LeftView, frontViewController: vc)
        window?.rootViewController = revealController
        
        dispatch_async(dispatch_get_global_queue(0, 0), {
        
        
            EMClient.sharedClient().addDelegate(self, delegateQueue: nil)
            let options = EMOptions.init(appkey: "xiaocool#qiezi")
            EMClient.sharedClient().initializeSDKWithOptions(options)
            if EMClient.sharedClient().options.isAutoLogin == true
            {
                let error = EMClient.sharedClient().loginWithUsername("zhu", password: "123")
                if(error  == nil)
                {
                    print("对话自动登录成功")
                }
                
            }else{
                let error = EMClient.sharedClient().loginWithUsername("zhu", password: "123")
                if(error == nil)
                {
                    print("对话登录成功")
                }
                EMClient.sharedClient().options.isAutoLogin = true
                
            }

        
        })
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
      
    }

    func applicationDidEnterBackground(application: UIApplication) {
         EMClient.sharedClient().applicationDidEnterBackground(application)
           }

    func applicationWillEnterForeground(application: UIApplication) {
         EMClient.sharedClient().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(application: UIApplication) {
       
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }

    
    //当自动登录的时候会调用此函数
    func didAutoLoginWithError(aError: EMError!) {
        if(aError != nil)
        {
            print("didAutoLoginWithError中错误为")
            print(aError)
        }
    }
    
    /*!
     *  SDK连接服务器的状态变化时会接收到该回调
     *
     *  有以下几种情况, 会引起该方法的调用:
     *  1. 登录成功后, 手机无法上网时, 会调用该回调
     *  2. 登录成功后, 网络状态变化时, 会调用该回调
     *
     *  @param aConnectionState 当前状态
     */
    
    func didConnectionStateChanged(aConnectionState: EMConnectionState) {
        print("didConnectionStateChanged中重新连接状态")
        print(aConnectionState)
    }
    
    /*!
     *  当前登录账号在其它设备登录时会接收到该回调
     */
    
    func didLoginFromOtherDevice() {
        print("此账号在其他的设备登录")
    }
    
    /*!
     *  当前登录账号已经被从服务器端删除时会收到该回调
     */
    
    func didRemovedFromServer() {
        print("当前账号已经从服务器中删除")
    }


}

