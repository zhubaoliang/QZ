//
//  ChangeVc.swift
//  QZ
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
class ChangeVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    let imageView:UIImageView = UIImageView.init()
    let takePictureButton:UIButton = UIButton.init()
    var image:UIImage = UIImage.init()
    var lastChosenMediaType = ""
    let nickname:UITextField = UITextField.init()
    let sex:UITextField = UITextField.init()
    let age:UITextField = UITextField.init()
    let school:UITextField = UITextField.init()
    let sign:UITextField = UITextField.init()
    var keyboardsize:CGSize = CGSize.init()
    var userphot:UIImage = UIImage.init()
    var data = NSData()
    var tablview:TableView = TableView.init()
    var imageURL = NSURL.init()
    let upFunc = UploadUserData.init()
    var Infomation:[String] = ["","","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterKeyboard()
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        setTablview()
        SetSavebutton()
        getUserBasicInformation()
        
    }
    
    func getUserBasicInformation()
    {
        let url = appurl + "getuserinfo"
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let Id:[String] = (userDefaults.objectForKey("userinfo") as? [String])!
        let param = ["userid":Id[2],"token":token]
        
        Alamofire.request(.GET, url, parameters: param).response
            {
                request, response, json, error in
                
                let result = ChangeList(JSONDecoder(json!))
                print("状态")
                print(result.status)
                print(request)
                if(result.status == "success")
                {
                    
                    var nickName = result.data?.userNickname
                    if(nickName == nil)
                    {
                        nickName = ""
                    }
                    var Sex = result.data?.sex
                    if(Sex == nil)
                    {
                        Sex = ""
                    }
                    var Age = result.data?.age
                    if(Age == nil)
                    {
                        Age = ""
                    }
                    var School = result.data?.school
                    if(School == nil)
                    {
                        School = ""
                    }
                    var Sign = result.data?.signature
                    if(Sign == nil)
                    {
                        Sign = ""
                    }
                    
                    self.Infomation =  [nickName!,Sex!,Age!,School!,Sign!]
                    
                    self.tablview.reloadData()
                }
                
                
        }
        
        
        
    }
    
    func setTablview()
    {
        tablview = TableView.init(frame: CGRectMake(0,0,self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Grouped)
        tablview.delegate = self
        tablview.dataSource = self
        self.view.addSubview(tablview)
    }
    func SetSavebutton()
    {
        
        let saveItem:UIBarButtonItem = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action:#selector(ChangeVc.savFunction) )
        self.navigationItem.rightBarButtonItem = saveItem
        
    }
    func savFunction()
    {
        print("上传")
        let dataUp:UploadUserData = UploadUserData.init()
        dataUp.upLoadUserData(nickname, Sex: sex, Age: age, School: school,sinNature:sign)
        dataUp.uploadUserPicture(data)
    }
    func RegisterKeyboard()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChangeVc.Keyboardshow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChangeVc.Keyboardhidd(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    func   Keyboardhidd(notif:NSNotification)
    {
        tablview.contentSize = CGSizeMake(0, self.view.frame.height)
    }
    func Keyboardshow(notif:NSNotification)
    {
        let info:NSDictionary = notif.userInfo!
        let value:AnyObject = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)!
        keyboardsize = value.CGRectValue().size
        tablview.contentSize = CGSizeMake(0, self.view.frame.height + keyboardsize.height)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        updateDisplay()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        //        let revealController:SWRevealViewController = self.revealViewController()
        //        revealController.setFrontViewPosition(FrontViewPosition.Right, animated: false)
    }
    //MARK:tablview delegate
    
    func cellHeightForIndexPath(indexPath: NSIndexPath!, cellContentViewWidth width: CGFloat) -> CGFloat {
        return 44
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else if(section == 1)
        {
            return 3
        } else if(section == 2)
        {
            return 1
        }else
        {
            return 1
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section
        {
            
        case 0:if(indexPath.row == 0)
        {
            let alertController = UIAlertController.init(title: "请选择方式", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            let pictureAssert = UIAlertAction.init(title: "本地相册", style: UIAlertActionStyle.Default, handler: {
                void in
                
                self.pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
                
            })
            
            let Camera = UIAlertAction.init(title: "相机", style: UIAlertActionStyle.Default, handler: {
                void in
                self.pickMediaFromSource(UIImagePickerControllerSourceType.Camera)
                
                
                
            })
            let canelSelect = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Default, handler: {
                void in
                
                         })
            
            alertController.addAction(pictureAssert)
            alertController.addAction(Camera)
            alertController.addAction(canelSelect)
            self.presentViewController(alertController, animated: true, completion: {
                Void in
            })
            
            }
        case 1:if(indexPath.row == 0)
        {
        }
        if(indexPath.row == 1)
        {
        }
        if(indexPath.row == 2)
        {
            
            }
        case 2:if(indexPath.row == 0)
        {
            
            }
        case 3:if(indexPath.row == 0)
        {
            
            }
            
        default: print("error")
            
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cellidentifier = "Cell"
        let cell:UITableViewCell = UITableViewCell.init(style: .Value1, reuseIdentifier: Cellidentifier)
        
        switch indexPath.section
        {
            
        case 0:if(indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.text = "上传头像"
            imageView.frame = CGRectMake(100, 0, 44, 44)
            
            cell.addSubview(imageView)
            
            }
        case 1:if(indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.text = "昵称"
            nickname.frame = CGRectMake(88, 0, self.view.frame.width - 88, 44)
            nickname.text = Infomation[0]
            cell.addSubview(nickname)
        }
        if(indexPath.row == 1)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.text = "性别"
            sex.frame = CGRectMake(88, 0, self.view.frame.width - 88, 44)
            sex.text = Infomation[1]
            cell.addSubview(sex)
        }
        if(indexPath.row == 2)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.text = "年龄"
            age.frame = CGRectMake(88, 0, self.view.frame.width - 88, 44)
            age.text = Infomation[2]
            cell.addSubview(age)
            }
        case 2:if(indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.text = "学校"
            school.frame = CGRectMake(88, 0, self.view.frame.width - 88, 44)
            school.text = Infomation[3]
            cell.addSubview(school)
            }
        case 3:if(indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.text = "个性签名"
            sign.frame = CGRectMake(176, 0, self.view.frame.width - 176, 44)
            sign.text = Infomation[4]
            cell.addSubview(sign)
            }
            
        default: print("error")
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
}
