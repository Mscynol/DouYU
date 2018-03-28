//
//  CarouseModel.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/27.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
@objcMembers
class CarouseModel : NSObject {
    // 标题
     var title : String = ""
    // 展示的图片地址
     var pic_url : String = ""
    // 主播信息对应的模型
    var authour : Author?
    // 主播信息对应的字典
     var room : [String : NSObject]? {
        didSet{
            guard  let room = room else {
                return
            }
            authour = Author(dict: room)
        }
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
