//
//  Activity.swift
//  QZ
//
//  Created by ios on 16/5/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class Activity: UITableViewController {
   
    let tetarray = ["fdsfdsfdsafdsafdsfdsagdsfbgdfhngynytnbgtntnrtnbrtnbtrbnrtbrtbtrgbgrtfbbghjgjgjgjgjgjugjbgjubgjlbjbhhnkljnkjlhnkljhnkjlbkjlbjklbjklbjklbjklbjklb"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ActivityCell = ActivityCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "Activity", pictureArray: [UIImage.init(named: "homepage_p4.jpg")!])
        cell.textLable.text = tetarray[0]
        cell.sign.text = tetarray[0]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.cellHeightForIndexPath(indexPath, cellContentViewWidth: self.view.frame.width, tableView: self.tableView)
    }
}
