//
//  CollectionViewPrettyCell.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/15.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
class CollectionViewPrettyCell: CollectionViewBasicCell {
  
    /// 控件属性
    @IBOutlet weak var cityButton: UIButton!
    
    /// 定义模型属性
    override var author : Author?{
        didSet{
            super.author = author
            // 3 城市
            cityButton.setTitle(author?.anchor_city, for: .normal)
        }
    }
}
