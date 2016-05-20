//
//  ChangeList.swift
//  QZ
//
//  Created by ios on 16/4/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class ChangeList: JSONJoy{
    var status:String?
    var data:getInfo?
    var avatarStaus:ChangeStatus?
    var errorData:String?
    var datastring:String?
    //var uid:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = getInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class getInfo: JSONJoy {
    var id:String?
    var userNickname:String?
    var age:String?
    var sex:String?
    var school:String?
    var signature:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        id = decoder["id"].string
        userNickname = decoder["user_nicename"].string
        age = decoder["age"].string
        sex = decoder["sex"].string
        school = decoder["city"].string
        signature = decoder["signature"].string
    }
}

class ChangeStatus: JSONJoy {
    var Status:String?
    init(){
    }
    required init(_ decoder: JSONDecoder) {
        Status = decoder["status"].string
    }
}
