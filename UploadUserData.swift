//
//  UploadUserData.swift
//  QZ
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
class UploadUserData {
    func uploadUserPicture(data:NSData)
    {
        let url = appurl + "uploadavatar"+"&token=qiezi123"+"&32"
        Alamofire.upload(.POST, url, data: data).response{
            request, response, json, error in
            print(response)
            let result = ChangeList(JSONDecoder(json!))
            //此处有BUG
            //print("上传图片状态为" + (result.avatarStaus?.Status)!)
           
            
        }
        
    }
    func upLoadUserData(nickName:UITextField,Sex:UITextField,Age:UITextField,School:UITextField,sinNature:UITextField)
    {
        if(nickName.text == nil)
        {
            nickName.text = ""
        }
        if(Sex.text == nil)
        {
            Sex.text = ""
        }
        if(Age.text == nil)
        {
            Age.text = ""
        }
        if(School.text == nil)
        {
            School.text = ""
        }
        if(sinNature.text == nil)
        {
            sinNature.text = ""
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let Id:[String] = userDefaults.objectForKey("userinfo") as! [String]
        let url = appurl + "savepersonalinfo"
        let param = ["userid":Id[2],"nicename":nickName.text!,"sex":Sex.text!,"age":Age.text!,"city":School.text!,"signature":sinNature.text!,"token":token]
        print("个性签名为"+sinNature.text!)
        Alamofire.request(.GET, url, parameters: param ).response{
            request, response, json, error in
            if(error != nil)
            {
                
            }else
            {
                print(request)
                print(response)
                print(error)
            }
            
        }
        
    }
    
    
}


