//
//  LoginView.swift
//  QZ
//
//  Created by xiaocool on 16/5/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.keyboardType = UIKeyboardType.NumberPad
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.8, blue: 1, alpha: 1)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 92 / 255, green: 24 / 255, blue: 109 / 255, alpha: 1)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userName.resignFirstResponder()
        passWord.resignFirstResponder()
    }
    
    @IBAction func LoginClicked()
    {
        let logfunc = Loginfunc()
        logfunc.checkUserMessageAndLogin(userName, passWord: passWord, target: self)
    }
    
   }
