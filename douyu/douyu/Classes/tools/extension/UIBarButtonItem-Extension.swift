//
//  UIBarButtonItem-Extension.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/8.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
//    class func createItem (imageName:String,highLightImageName:String,imageSize:CGSize)->UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:highLightImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: imageSize)
//        return UIBarButtonItem(customView: btn)
//    }
    
    
    /// 便利构造函数
    /// 1 > 必须以convenience关键字开头
    /// 2 > 在构造函数中必须明确调用一个设计的构造函数,并且这个构造函数使用(self)来调用的
    ///
    /// - Parameters:
    ///   - imageName:默认未点击图片名称
    ///   - highLightImageName: 点击图片名称
    ///   - imageSize: 图片自定义大小
    convenience init(imageName:String,highLightImageName:String="",imageSize:CGSize=CGSize.zero) {
        // 1 > 创建UIButton
        let viewButton = UIButton()
        // 2 > 设置UIButton的照片
        viewButton.setImage(UIImage(named:imageName), for: .normal)
        if highLightImageName != ""{
            viewButton.setImage(UIImage(named:highLightImageName), for: .highlighted)
        }
        // 3 >设置UIButton的照片的大小
        if imageSize == CGSize.zero{
            viewButton.sizeToFit()
        }else{
            viewButton.frame = CGRect(origin: CGPoint.zero, size: imageSize)
        }
        // 4 > 创建UIBarButtonItem
        self.init(customView: viewButton)
    }
}
