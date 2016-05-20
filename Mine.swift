//
//  Mine.swift
//  QZ
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class Mine: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    let bgPicture = UIImageView()
    var tableview = UITableView()
    var tableViewLableText:[String] = ["我的关注","我的交易","我的私信","时光轴"]
    var profileButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundPicture()
        setTableView()
        self.title = "我"
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
    }
    
    func setButton()
    {
    
        
    }
        func setBackgroundPicture()
    {
        bgPicture.image = UIImage.init(named: "homepage_pic2.jpg")
        bgPicture.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height / 3)
        self.view.addSubview(bgPicture)
    }
    
    func setTableView()
    {
        tableview = UITableView.init(frame: CGRectMake(0, self.view.frame.height / 3, self.view.frame.width, self.view.frame.height * 2 / 3), style: UITableViewStyle.Grouped)
        tableview.delegate = self
        tableview.dataSource = self
        
        self.view.addSubview(tableview)
    }
    //MARK: -tableviewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MineCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "MinetableView")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.images.image = UIImage.init(named: "homepage_pic2.jpg")
        cell.lable.text = tableViewLableText[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let testView = UIViewController.init()
        testView.view.backgroundColor = UIColor.yellowColor()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(testView, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
}
