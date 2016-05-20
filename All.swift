//
//  HomeView.swift
//  QZ
//
//  Created by xiaocool on 16/5/6.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import SDCycleScrollView
import MJRefresh
class All: UIViewController,SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate{
    var fixFrame = CGRect()
    var cyclePicture = SDCycleScrollView()
    var collectinViewAny:AnyObject!
    var titleArray:[String] = ["11","222","333","444","55","66","77","888"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setCyclePicture()
        refreshConfig()
    }
    //设置刷新
    func refreshConfig()
    {
        (collectinViewAny as! UICollectionView).mj_header = MJRefreshHeader()
        //假设置刷新时间
        (collectinViewAny as! UICollectionView).mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()){
                
                (self.collectinViewAny as! UICollectionView).mj_header.endRefreshing()
                
            }
            
        })
        (collectinViewAny as! UICollectionView).mj_header.beginRefreshing()
    }

    
    func setCollectionView()
    {
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .Vertical
        layOut.minimumInteritemSpacing = 0
        layOut.minimumLineSpacing = 5
        let collectionView  = UICollectionView.init(frame: fixFrame, collectionViewLayout: layOut)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(WaterCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        collectinViewAny = collectionView
        self.view.addSubview(collectionView)
    }

    
    func setCyclePicture()
    {
        
        cyclePicture = SDCycleScrollView.init(frame: CGRectMake(0,0, self.view.frame.width, self.view.frame.height/4), imageNamesGroup: ["homepage_p3.jpg","homepage_p4.jpg","homepage_pic1.jpg","homepage_pic2.jpg"])
        cyclePicture.titlesGroup = ["111","222","333","4444"]
        cyclePicture.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        cyclePicture.titleLabelBackgroundColor = UIColor(red:  128 / 255, green: 20 / 255, blue: 128 / 255, alpha: 0.5)
        cyclePicture.delegate = self
        self.collectinViewAny.addSubview(cyclePicture)
    }
    
    //MARK: SDCycleScrollViewDelegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        print("点击了第%d",index)
    }

    
    //MARK: CollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! WaterCell
        cell.imageView.layer.masksToBounds = true
        cell.imageTitle.text = titleArray[indexPath.row]
        cell.imageView.image = UIImage.init(named: "homepage_p3.jpg")
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath)
        headView.backgroundColor = UIColor.whiteColor()
        
        return headView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("点击了图片")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: UINavigationController.init().navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height + self.view.frame.height / 2 + 40 + 46)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((self.view.frame.width - 10)/3, (self.view.frame.width - 20) / 3 + 50 );
    }



}
