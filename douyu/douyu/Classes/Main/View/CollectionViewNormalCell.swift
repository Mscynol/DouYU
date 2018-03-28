//
//  CollectionViewNormalCell.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/15.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionViewBasicCell {

    /// 控件属性
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    /// 定义模型属性
    override var author : Author?{
        didSet{
            super.author = author
            /// 房间名称
            roomNameLabel.text = author?.room_name
        }
    }

}
