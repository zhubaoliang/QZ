//
//  ActivityCell.swift
//  QZ
//
//  Created by ios on 16/5/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class ActivityCell: UITableViewCell {
    let userImageView = UIImageView()
    let textLable = UILabel()
    var pictureView = UIView()
    let sign = UILabel()
    var pictures = UIView()
    var zanButton = UIButton()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,pictureArray:[UIImage]) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userImageView.backgroundColor = UIColor.redColor()
        textLable.backgroundColor = UIColor.blueColor()
        sign.backgroundColor = UIColor.grayColor()
        pictures = collectionPictures.init(imagesArray: pictureArray)
        
        self.contentView.sd_addSubviews([userImageView,textLable,sign,pictures])
        
        userImageView.sd_layout()
        .topSpaceToView(self.contentView,10)
        .leftSpaceToView(self.contentView,10)
        .heightIs(50)
        .widthIs(50)
        
        sign.sd_layout()
        .heightIs(50)
        .rightSpaceToView(self.contentView,10)
        .leftSpaceToView(userImageView,5)
        .topSpaceToView(self.contentView,10)
        
        textLable.sd_layout()
        .topSpaceToView(userImageView,5)
        .leftSpaceToView(self.contentView,10)
        .rightSpaceToView(self.contentView,10)
        .autoHeightRatio(0)
        
        switch pictureArray.count {
        case 1:
        pictures.sd_layout()
        .autoHeightRatio(1)
        .leftSpaceToView(self.contentView,10)
        .rightSpaceToView(self.contentView,self.contentView.frame.width  / 3)
        .topSpaceToView(textLable,5)
        case 2:
        pictures.sd_layout()
        .autoHeightRatio(1)
        .leftSpaceToView(self.contentView,10)
        .rightSpaceToView(self.contentView,self.contentView.frame.width  / 3)
        .topSpaceToView(textLable,5)
            
            
        default:
            print("超出范围")
        }
        
        
        
        
        self.setupAutoHeightWithBottomViewsArray([pictures], bottomMargin: 10)
        
    }
    
}
