//
//  MineCell.swift
//  QZ
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class MineCell: UITableViewCell {
    let images = UIImageView()
    let lable = UILabel()
       required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        images.frame = CGRectMake(10, 0,self.bounds.height, self.bounds.height)
        self.addSubview(images)
        lable.frame = CGRectMake( 20 + self.bounds.height, 0, self.bounds.width - 20 - self.bounds.height, self.bounds.height)
        self.addSubview(lable)
        
    }
    }
