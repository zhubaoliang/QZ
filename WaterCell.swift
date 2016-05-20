//
//  WaterCell.swift
//  QZ
//
//  Created by xiaocool on 16/5/6.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class WaterCell: UICollectionViewCell {
    var imageView = UIImageView()
    var imageTitle = UILabel()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = bounds
        imageView.contentMode = .ScaleAspectFill
        imageTitle.frame  = CGRectMake(0, frame.height-20, frame.width, 20)
        imageTitle.backgroundColor = UIColor.init(red: 248 / 255, green: 248 / 255, blue: 1, alpha: 0.5)
        addSubview(imageTitle)
    }
}
