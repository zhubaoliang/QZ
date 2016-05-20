//
//  ExtensionChangvc.swift
//  QZ
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
extension ChangeVc{
    
    func selectExistingPictureOrVideo()
    {
        self.pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    func updateDisplay()
    {
        self.imageView.image = self.image
        
    }
    
    func pickMediaFromSource(sourceType:UIImagePickerControllerSourceType)
    {
        let mediaTypes:NSArray = UIImagePickerController.availableMediaTypesForSourceType(sourceType)!
        if((UIImagePickerController.isSourceTypeAvailable(sourceType)) && (mediaTypes.count > 0))
        {
            let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
            let picker:UIImagePickerController = UIImagePickerController.init()
            picker.mediaTypes = mediaTypes! as [String]
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            let revealController:SWRevealViewController = self.revealViewController()
            revealController.rearViewController.presentViewController(picker, animated: true, completion: {
                void in
                revealController.setFrontViewPosition(FrontViewPosition.Left, animated: true)
                
            })
            
        }else
            
        {
            print("Unsupported media source.")
        }
        
    }
    
    func shrinkImage(original:UIImage,size:CGSize) ->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let originalAspect:CGFloat = original.size.width / original.size.height
        let targetAspect:CGFloat = size.width / size.height
        var targetRect:CGRect = CGRect.init()
        if(originalAspect > targetAspect)
        {
            targetRect.size.width = size.width
            targetRect.size.height = size.height * targetAspect / originalAspect
            targetRect.origin.x = 0
            targetRect.origin.y = (size.height - targetRect.size.height) * 0.5
        }else if(originalAspect < targetAspect)
        {
            targetRect.size.width = size.width * originalAspect / targetAspect;
            targetRect.size.height = size.height;
            targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
            targetRect.origin.y = 0;
        }else
        {
            targetRect = CGRectMake(0, 0, size.width, size.height);
        }
        original.drawInRect(targetRect)
        var final:UIImage = UIImage.init()
        final = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        data = UIImageJPEGRepresentation(final, 1)!
        return final
    }
    //Image Picker Controller delegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.lastChosenMediaType = (String)(info[UIImagePickerControllerMediaType])
        
        //imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let chosenImage:AnyObject = info[UIImagePickerControllerEditedImage]!
        self.image = self.shrinkImage(chosenImage as! UIImage, size: self.imageView.bounds.size)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}


