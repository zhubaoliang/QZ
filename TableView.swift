//
//  TableView.swift
//  QZ
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class TableView: UITableView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view:AnyObject = super.hitTest(point, withEvent: event)!
        if(!view.isKindOfClass(UITextField))
        {
            self.endEditing(true)
            return self
        }else
        {
            return view as? UIView
            
        }
        
    }
}

