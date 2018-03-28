//
//  AuthorGroup.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/20.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
@objcMembers
class AuthorGroup: NSObject {
    
    /// 该组中房间信息
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list{
                authors.append(Author(dict:dict))
            }
        }
    }
    
    /// 改组显示标题
    var tag_name : String = ""
    
    /// 该组显示头标
    var icon_url : String = ""
    
    /// 定义主播的模型对象数组
    lazy var authors : [Author] = [Author]()
    
//    var room_id : Int = 0
//    var vertical_src : String = ""
//    var isVertical : Int = 0
//    var room_name : String = ""
//    var nickname : String = ""
//    var online : Int = 0
//    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            if let dataArray = value as? [[String : Any]]{
//                for dict in dataArray{
//                    authors.append(Author(dict:dict))
//                }
//            }
//        }
//    }
    
}
