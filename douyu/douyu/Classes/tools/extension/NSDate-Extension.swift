//
//  NSDate-Extension.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/20.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
extension NSDate{
    class func getCurrentTime() -> String{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
