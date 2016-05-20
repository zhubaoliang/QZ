//
//  ChatController.swift
//  QZ
//
//  Created by xiaocool on 16/5/5.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class ChatController:EaseMessageViewController, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource  {
    var avatarImage = UIImage()
    var nikNmae = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.hidesBottomBarWhenPushed = true
        self.dataSource = self
        
    }
    override func viewWillDisappear(animated: Bool) {
        
        self.conversation.markAllMessagesAsRead()
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        //self.hidesBottomBarWhenPushed = false
    }
    
    // EaseMessageViewControllerDataSource 方法
    
    func messageViewController(viewController: EaseMessageViewController!, modelForMessage message: EMMessage!) -> IMessageModel! {
        let model = EaseMessageModel.init(message: message)
        
        let currname = EMClient.sharedClient().currentUsername
        let msgname = model.message.from
        if currname == msgname
        {
            model.avatarImage = UIImage.init(named: "drawbg.jpg")
        }else
        {
            model.avatarImage = avatarImage
        }
        model.nickname = nikNmae
        return model
    }
    
    
    
}
