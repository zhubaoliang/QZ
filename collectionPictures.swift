//
//  collectionPictures.swift
//  QZ
//
//  Created by ios on 16/5/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class collectionPictures: UIView {
    var cFrame = CGRectMake(0, 0, 0, 0)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(imagesArray:[UIImage]) {
        switch imagesArray.count {
        case 0:
            print("无照片")
        case 1:
            cFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 2 / 3 - 10, UIScreen.mainScreen().bounds.width * 2 / 3 - 10 )
            
        default:
            print("超出范围")
        }
      super.init(frame: cFrame)
        
        switch imagesArray.count {
        case 1:
            let image0 = UIImageView()
            image0.image = imagesArray[0]
            image0.frame = cFrame
            self.addSubview(image0)
        default:
            print("超出范围")
        }
    }
}
