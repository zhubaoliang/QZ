//
//  ChatList.swift
//  QZ
//
//  Created by ios on 16/5/10.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class ChatList: EaseConversationListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMessages(aMessages: [AnyObject]!) {
        self.refreshAndSortView()
        self.tableViewDidTriggerFooterRefresh()
        print("毁掉")
    }
}
