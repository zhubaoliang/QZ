//
//  ViewController.swift
//  QZ
//
//  Created by ios on 16/5/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import SDCycleScrollView
class ViewController: UIViewController{
    var toolBar:UIToolbar = UIToolbar()
    var fixFrame = CGRect()
    var titleViewFrame = CGRect()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐"
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "TopLan.png"), forBarMetrics: UIBarMetrics.Default)
            fixFrame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.height, width: view.bounds.size.width, height: view.bounds.size.height - (self.navigationController?.navigationBar.frame.height)! - (self.tabBarController?.tabBar.frame.height)! - UIApplication.sharedApplication().statusBarFrame.height)
            titleViewFrame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - (self.navigationController?.navigationBar.frame.height)! - (self.tabBarController?.tabBar.frame.height)! - UIApplication.sharedApplication().statusBarFrame.height - 44)
        self.view.backgroundColor = UIColor.blueColor()
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        // 滚动条
        style.showLine = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 滚动条颜色
        style.scrollLineColor = UIColor(red:  110 / 255, green: 41 / 255, blue: 142 / 255, alpha: 1.0)
        style.normalTitleColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        style.selectedTitleColor = UIColor(red:  110 / 255, green: 41 / 255, blue: 142 / 255, alpha: 1.0)
        let titles = setChildVcs().map { $0.title! }
        
        let scroll = ScrollPageView(frame: fixFrame, segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        scroll.segmentView.backgroundImage = UIImage.init(named: "TopLan1.png")
        view.addSubview(scroll)
        
        //设置toolbar
        setToolBar()
        
    }
    
    func setChildVcs() -> [UIViewController] {
        let vc1 = All()
        vc1.fixFrame = titleViewFrame
        vc1.view.backgroundColor = UIColor.redColor()
        vc1.title = "全部"
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.greenColor()
        vc2.title = "校园"
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.redColor()
        vc3.title = "街拍"
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.yellowColor()
        vc4.title = "唯美"
        
        let vc5 = UIViewController()
        vc5.view.backgroundColor = UIColor.lightGrayColor()
        vc5.title = "毕业季"
        
        let vc6 = UIViewController()
        vc6.view.backgroundColor = UIColor.brownColor()
        vc6.title = "雪景"
        
        let vc7 = UIViewController()
        vc7.view.backgroundColor = UIColor.orangeColor()
        vc7.title = "国防要事"
        
        let vc8 = UIViewController()
        vc8.view.backgroundColor = UIColor.blueColor()
        vc8.title = "科技频道"
        
        let vc9 = UIViewController()
        vc9.view.backgroundColor = UIColor.brownColor()
        vc9.title = "手机专页"
        
        let vc10 = UIViewController()
        vc10.view.backgroundColor = UIColor.orangeColor()
        vc10.title = "风景图"
        
        let vc11 = UIViewController()
        vc11.view.backgroundColor = UIColor.blueColor()
        vc11.title = "段子"
        
        return [vc1, vc2, vc3,vc4, vc5, vc6, vc7, vc8, vc9, vc10, vc11]
    }
    
    func setToolBar()
    {
        toolBar.frame = CGRectMake(0, 0, self.view.frame.height, (self.navigationController?.navigationBar.frame.height)!)
        toolBar.alpha = 0
        self.navigationController?.navigationBar.addSubview(toolBar)
    }
    
}

