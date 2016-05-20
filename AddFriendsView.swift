//
//  AddFriendsView.swift
//  QZ
//
//  Created by xiaocool on 16/5/6.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class AddFriendsView: UIViewController {
    @IBOutlet weak var checkMessageTextField: UITextField!
    @IBOutlet weak var searachTextField: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchButton.layer.cornerRadius = 10
        
    }
    @IBAction func searchButtonClicked(sender:AnyObject)
    {
        let Error = EMClient.sharedClient().contactManager.addContact(EMClient.sharedClient().currentUsername, message: checkMessageTextField.text)
        print(Error)
        if(Error == nil)
        {
            print("发送请求成功")
        }
    }
}