//
//  Author.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/22.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
@objcMembers
class Author: NSObject {
    /// 房间ID
    var room_id : Int = 0
    /// 房间对应图片
    var vertical_src : String = ""
    /// 判断是否是手机直播 1 还是电脑直播 0
    var isVertical : Int = 0
    /// 房间名字
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 在线人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
