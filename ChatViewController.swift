//
//  ChatViewController.swift
//  Demo
//
//  Created by zhang on 16/3/29.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class ChatViewController: EaseMessageViewController, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource{

    var _copyMenuItem = UIMenuItem()
    var _deleteMenuItem = UIMenuItem()
    var _transpondMenuItem = UIMenuItem()
    let isPlayingAudio = Bool()
    let emotionDic = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showRefreshHeader = true
        self.delegate = self
        self.dataSource = self
        
        EaseBaseMessageCell.appearance().sendBubbleBackgroundImage = UIImage(named: "chat_sender_bg")!.stretchableImageWithLeftCapWidth(5, topCapHeight: 35)
        EaseBaseMessageCell.appearance().recvBubbleBackgroundImage = UIImage(named: "chat_receiver_bg")!.stretchableImageWithLeftCapWidth(35, topCapHeight: 35)
    
        EaseBaseMessageCell.appearance().sendMessageVoiceAnimationImages = [(UIImage)(named: "chat_sender_audio_playing_full")!,(UIImage)(named: "chat_sender_audio_playing_000")!,(UIImage)(named: "chat_sender_audio_playing_001")!,(UIImage)(named: "chat_sender_audio_playing_002")!,(UIImage)(named: "chat_sender_audio_playing_003")!]
       
        EaseBaseMessageCell.appearance().recvMessageVoiceAnimationImages = [(UIImage)(named: "chat_receiver_audio_playing_full")!,(UIImage)(named: "chat_receiver_audio_playing000")!,(UIImage)(named: "chat_receiver_audio_playing001")!,(UIImage)(named: "chat_receiver_audio_playing002")!,(UIImage)(named: "chat_receiver_audio_playing003")!]
        EaseBaseMessageCell.appearance().avatarSize = 40
        EaseBaseMessageCell.appearance().avatarCornerRadius = 20
        
        EaseBaseMessageCell.appearance().backgroundColor = UIColor(red: 240 / 255.0, green: 242 / 255.0, blue: 247 / 255.0, alpha: 1)
       self._setupBarButtonItem()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deleteAllMessages:", name: "RemoveAllMessages", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "exitGroup", name: "ExitGroup", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "insertCallMessage:", name: "insertCallMessage", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "callOutWithChatter:", name: "callOutWithChatter", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "callControllerClose:", name: "callControllerClose", object: nil)
    //通过会话管理者获取已收发消息
        self.tableViewDidTriggerHeaderRefresh()
    }
    deinit {
        if self.conversation.type == EMConversationType.init(0){
//            退出聊天室，删除会话
            let chatter:String = self.conversation.conversationId as String
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                let error = EMError()
                EMClient.sharedClient().roomManager.leaveChatroom(chatter, error: nil)
                if  !error.isEqual(nil) {
                   dispatch_async(dispatch_get_main_queue(), { () -> Void in
                      let alertView = UIAlertController(title: "Error", message: "Leave chatroom '\(chatter)' failed [\(error.description)]", preferredStyle: .Alert)
                       alertView.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
                    self.presentViewController(alertView, animated: true, completion: nil)
                   })
                }
            })
            
        }
        EMClient.sharedClient().chatManager.removeDelegate(self)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(self.conversation.type == EMConversationType.init(1)){
            let sub:String = self.conversation.ext["subject"] as! String
            if (!sub.isEmpty) {
                self.title = self.conversation.ext["subject"] as? String
            }
        
        }
    }
    func _setupBarButtonItem(){
       let backButton = UIButton()
        backButton.frame = CGRectMake(0, 0, 30, 30)
        backButton.setBackgroundImage((UIImage(named: "back.png")), forState: .Normal)
        backButton.addTarget(self, action: "backAction", forControlEvents: .TouchUpInside)
        let backItem:UIBarButtonItem = UIBarButtonItem.init(customView: backButton)
        self.navigationItem.setLeftBarButtonItem(backItem, animated: true)
        
//      单聊
        if(self.conversation.type == EMConversationType.init(0)){
            let clearButton = UIButton()
            clearButton.frame = CGRectMake(0, 0, 30, 30)
            clearButton.setBackgroundImage((UIImage(named: "delete")), forState: .Normal)
            clearButton.addTarget(self, action: "deleteAllMessages:", forControlEvents: .TouchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: clearButton)
        }else{//群聊
            let detailButton = UIButton()
            detailButton.frame = CGRectMake(0, 0, 60, 44)
            detailButton.setBackgroundImage((UIImage(named: "group_detail")), forState: .Normal)
            detailButton.addTarget(self, action: "showGroupDetailAction", forControlEvents: .TouchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: detailButton)
           
        }
    }
    
    func messageViewController(viewController: EaseMessageViewController!, canLongPressRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    func messageViewController(viewController: EaseMessageViewController!, didLongPressRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        let object = self.dataArray.objectAtIndex(indexPath.row)
        if !(object is String) {
            let cell:EaseMessageCell = self.tableView.cellForRowAtIndexPath(indexPath) as! EaseMessageCell
            cell.becomeFirstResponder()
            self.menuIndexPath = indexPath
            self._showMenuViewController(cell.bubbleView, indexPath: indexPath, messageType: cell.model.bodyType)
        }
        return true
    }
    
    func emotionFormessageViewController(viewController: EaseMessageViewController!) -> [AnyObject]! {
        let emotions = NSMutableArray()
        for name in EaseEmoji.allEmoji(){
            let  emotion = EaseEmotion(name: "", emotionId: name as! String, emotionThumbnail: name as! String, emotionOriginal: name as! String, emotionOriginalURL: "", emotionType:EMEmotionType.Default)
            emotions.addObject(emotion)
        }
        let temp:EaseEmotion = emotions.objectAtIndex(0) as! EaseEmotion
        let managerDefault = EaseEmotionManager(type: .Default, emotionRow: 3, emotionCol: 7, emotions: emotions as [AnyObject], tagImage: UIImage(named: temp.emotionId))
        let emotionGifs = NSMutableArray()
        let names:[String] = ["icon_002","icon_007","icon_010","icon_012","icon_013","icon_018","icon_019","icon_020","icon_021","icon_022","icon_024","icon_027","icon_029","icon_030","icon_035","icon_040"]
        var index = 0
        for name in names {
            index++
            let emotion = EaseEmotion(name: "示例\(String(index))", emotionId: "em\(String(1000+index))", emotionThumbnail: "\(name)_cover", emotionOriginal: name, emotionOriginalURL: "", emotionType: .Gif)
            emotionGifs.addObject(emotion)
            emotionDic.setObject(emotion, forKey: "em\(String(1000+index))")
        }
        let managerGif = EaseEmotionManager(type: .Gif, emotionRow: 2, emotionCol: 4, emotions: emotionGifs as [AnyObject], tagImage: UIImage(named: "icon_002_cover"))
        return [managerDefault,managerGif]
    }
    func isEmotionMessageFormessageViewController(viewController: EaseMessageViewController!, messageModel: IMessageModel!) -> Bool {
        let flag:Bool = false
        return flag
    }
    func emotionURLFormessageViewController(viewController: EaseMessageViewController!, messageModel: IMessageModel!) -> EaseEmotion! {
        let emotionId:String = messageModel.message.ext["em_expression_id"] as! String
        var emotion:EaseEmotion = emotionDic.objectForKey(emotionId) as! EaseEmotion
        if (emotion.isEqual(nil)) {
            emotion = EaseEmotion(name: "", emotionId: "", emotionThumbnail: "", emotionOriginal: "", emotionOriginalURL: "", emotionType: .Gif)
        }
        return emotion
    }
    func emotionExtFormessageViewController(viewController: EaseMessageViewController!, easeEmotion: EaseEmotion!) -> [NSObject : AnyObject]! {
        return ["em_expression_id":easeEmotion.emotionId,"em_is_big_expression":(true)]
    }
     func didLoginFromOtherDevice() {
        let firstString:String = self.imagePicker.mediaTypes.first!
        if self.imagePicker.mediaTypes.count>0 && firstString == String(kUTTypeMovie){
           self.imagePicker.stopVideoCapture()
        }
    }
     func didRemovedFromServer() {
        if self.imagePicker.mediaTypes.count>0 && self.imagePicker.mediaTypes.first! == String(kUTTypeMovie){
            self.imagePicker.stopVideoCapture()
        }
    }
    func backAction(){
        EMClient.sharedClient().chatManager.removeDelegate(self)
//        当会话为空时移除会话
        if(self.deleteConversationIfNull){
            EMClient.sharedClient().chatManager.deleteConversation(self.conversation.conversationId, deleteMessages: false)
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    func showGroupDetailAction(){
         self.view.endEditing(true)
    }
    func deleteAllMessages(sender:AnyObject){
        if self.dataArray.count == 0 {
            self.showHint(NSLocalizedString("message.noMessage", comment: "no messages"))
            return
        }
        if sender.isKindOfClass(NSNotification) {
            let groupId:String = sender.object as! String
            var isDelete = Bool()
            if groupId == self.conversation.conversationId {
                isDelete = true
            }else{
                isDelete = false
            }
            
            if self.conversation.type == EMConversationType.init(0) && isDelete {
                  self.messageTimeIntervalTag = -1
//                EMClient.sharedClient().chatManager.deleteConversations(<#T##aConversations: [AnyObject]!##[AnyObject]!#>, deleteMessages: <#T##Bool#>)
                self.messsagesSource.removeAllObjects()
                self.dataArray.removeAllObjects()
                
                self.tableView.reloadData()
                self.showHint(NSLocalizedString("message.noMessage", comment: "no messages"))
            }
            
        }else if sender.isKindOfClass(UIButton) {
             let alertView = UIAlertController(title: NSLocalizedString("prompt",  comment:"Prompt"), message: NSLocalizedString("sureToDelete",  comment:"please make sure to delete"), preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment:"Cancel"), style: .Default, handler: nil))

            alertView.addAction(UIAlertAction(title: NSLocalizedString("ok", comment:"OK"), style: .Default, handler: { (UIAlertAction) -> Void in
                self.messageCountOfPage = -1
                self.conversation.deleteAllMessages()
                self.dataArray.removeAllObjects()
                self.messsagesSource .removeAllObjects()
                self.tableView.reloadData()
            }))
            self.presentViewController(alertView, animated: true, completion: nil)

        }
        
        
    }
    func transpondMenuAction(sender:AnyObject){
        if self.menuIndexPath != 0 && self.menuIndexPath.row>0 {
            let model:IMessageModel = self.dataArray.objectAtIndex(self.menuIndexPath.row) as! IMessageModel
            
          }
        self.menuIndexPath = nil
    }
    func copyMenuAction(sender:AnyObject){
        let pasteboard = UIPasteboard.generalPasteboard()
        if(self.menuIndexPath != 0 && self.menuIndexPath.row>0){
            let model:IMessageModel = self.dataArray.objectAtIndex(self.menuIndexPath.row) as! IMessageModel
            pasteboard.string = model.text
        }
        self.menuIndexPath = nil
    }
    func deleteMenuAction(sender:AnyObject){
//        if self.menuIndexPath != nil && self.menuIndexPath.row > 0 {
//            let model:IMessageModel = self.dataArray.objectAtIndex(self.menuIndexPath.row) as! IMessageModel
//            let indexs = NSMutableIndexSet(indexSet: NSIndexSet(index: self.menuIndexPath.row))
//            let indexPaths = NSMutableArray(objects: self.menuIndexPath!)
//            
//            self.conversation.removeMessageWithId(model.message.messageId)
//            self.messsagesSource.removeObject(model.message)
//            
//            if self.menuIndexPath.row-1 >= 0 {
//                let nextMessage:AnyObject
//                let prevMessage:AnyObject = self.dataArray.objectAtIndex(self.menuIndexPath.row-1)
//                if self.menuIndexPath.row+1 < self.dataArray.count {
//                     nextMessage = self.dataArray.objectAtIndex(self.menuIndexPath.row+1)
//                }
//                
//            }
//            self.dataArray.removeObjectsAtIndexes(indexs)
//            self.tableView.beginUpdates()
//            self.tableView.endUpdates()
//            if self.dataArray.count == 0 {
//                self.messageTimeIntervalTag = -1
//            }
//        }
//        self.menuIndexPath = nil
    }
    func exitGroup(){
        self.navigationController?.popToViewController(self, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    func insertCallMessage(notification:NSNotification){
        let object:AnyObject = notification.object!
        if object.isEqual(nil) {
            let message = EMMessage()
            self.addMessageToDataSource(message, progress: nil)
            EMClient.sharedClient().dataMigrationTo3()
        }
    }
    func handleCallNotification(notification:NSNotification){
       let object:AnyObject = notification.object!
        if object.isKindOfClass(NSDictionary) {
            //开始call
            self.isViewDidAppear = false
        }else{
            //结束call
            self.isViewDidAppear = true
        }
    }
    func _showMenuViewController(showInView:UIView,indexPath:NSIndexPath,messageType:EMMessageBodyType){
        if self.menuController == nil {
            self.menuController = UIMenuController.sharedMenuController()
        }
        _deleteMenuItem = UIMenuItem(title: NSLocalizedString("delete", comment: "Delete"), action: "deleteMenuAction:")
        _copyMenuItem = UIMenuItem(title: NSLocalizedString("copy", comment: "Copy"), action: "copyMenuAction:")
        _transpondMenuItem = UIMenuItem(title: NSLocalizedString("transpond", comment: "Transpond"), action: "transpondMenuAction:")

        
        if messageType == EMMessageBodyType.init(1) {
            self.menuController.menuItems = [_copyMenuItem,_deleteMenuItem,_transpondMenuItem]
        }else if messageType == EMMessageBodyType.init(2){
            self.menuController.menuItems = [_deleteMenuItem,_transpondMenuItem]
        }else{
            self.menuController.menuItems = [_deleteMenuItem]
        }
        self.menuController.setTargetRect(showInView.frame, inView:showInView.superview!)
        self.menuController.setMenuVisible(true, animated: true)
        
    }
}
