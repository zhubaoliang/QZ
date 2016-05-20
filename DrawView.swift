//
//  DrawView.swift
//  QZ
//
//  Created by xiaocool on 16/5/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class DrawView: UIViewController {
    @IBOutlet weak var bgPicture: UIImageView!
    @IBOutlet weak var changData: UIButton!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var Home: UIButton!
    @IBOutlet weak var SetButton: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var TimeZhou: UIButton!
    @IBOutlet weak var YouHui: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.8, blue: 1, alpha: 1)
        setChangeBtn()
        
    }
    
    func setChangeBtn()
    {
        changData.frame = CGRectMake(10,bgPicture.frame.height - 30, 200, 30)
        changData.backgroundColor = UIColor.purpleColor()
        changData.layer.cornerRadius = 12
    }

    @IBAction func changeData()
    {
        let revealController:SWRevealViewController = self.revealViewController()
        let changeDatVc = UINavigationController.init(rootViewController: ChangeVc())
        revealController.pushFrontViewController(changeDatVc, animated: true)
        
    }

    @IBAction func HomeBtn()
    {
        let revealController:SWRevealViewController = self.revealViewController()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainView")
         revealController.pushFrontViewController(vc, animated: true)
        
    }
    @IBAction func logOutBtnActivity()
    {
    
        if((EMClient.sharedClient().logout(true)) == nil)
        {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userinfo")
            print("退出成功")
        }
        let revealController:SWRevealViewController = self.revealViewController()
      
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let LogVC = mainStoryboard.instantiateViewControllerWithIdentifier("logVC")
        let navigationController = UINavigationController(rootViewController: LogVC)
        revealController.pushFrontViewController(navigationController, animated: true)
        
        //self.navigationController?.pushViewController(navigationController, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
}
