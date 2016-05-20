//
//  FriendsList.swift
//  QZ
//
//  Created by xiaocool on 16/5/5.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class FriendsList: UITableViewController,EMContactManagerDelegate{
    var friendArray = []
    var NetState = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.init(red: 100 / 255, green: 10 / 255, blue: 100 / 255 , alpha: 1)
        checkNetStat()
        if(NetState)
        {
            //为了使画面更加流畅
        self.friendArray = EMClient.sharedClient().contactManager.getContactsFromDB()
            self.tableView.reloadData()
            
        dispatch_async(dispatch_get_global_queue(0, 0), {
        var Error = AutoreleasingUnsafeMutablePointer<EMError?>.init()
        Error = nil
        self.friendArray = EMClient.sharedClient().contactManager.getContactsFromServerWithError(Error)
        if Error == nil
        {
            print("服务器获取好友成功")
            print(self.friendArray)
            
        }
        self.friendArray = EMClient.sharedClient().contactManager.getContactsFromDB()
            dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
            
        })
        })}else{
            self.friendArray = EMClient.sharedClient().contactManager.getContactsFromDB()
            self.tableView.reloadData()
        }
        
    }
    
    //判断网络状态
    func checkNetStat()
    {
        let state:Reachability = Reachability.reachabilityForInternetConnection()
        let status = state.currentReachabilityStatus()
        switch status {
        case NotReachable:
            print("无网络")
            NetState = false
        case ReachableViaWiFi:
            print("使用Wi-Fi")
            NetState = true
        case ReachableViaWWAN:
            print("use wwan")
            NetState = true
        default:
            print("unknow")
            NetState = true
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        
    }
    //tablview的代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArray.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "friendsList")
        cell.textLabel?.text = friendArray[indexPath.row] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let chatUi = ChatController.init(conversationChatter: tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text, conversationType: EMConversationTypeChat)
        chatUi.avatarImage = UIImage.init(named: "mohu.jpg")!
        chatUi.nikNmae = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!
        chatUi.title = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatUi, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
