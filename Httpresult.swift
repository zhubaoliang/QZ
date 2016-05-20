//
//  Httpresult.swift
//  QZ
//
//  Created by ios on 16/5/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class Httpresult: JSONJoy{
    var status:String?
    var data:UserInfo?
    var errorData:String?
    var datastring:String?
    //var uid:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = UserInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class UserInfo: JSONJoy {
    var id:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        id = decoder["id"].string
        
    }
}

