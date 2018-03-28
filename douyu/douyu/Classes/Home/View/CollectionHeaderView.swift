//
//  CollectionHeaderView.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/14.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    /// 控件属性
   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView:UIImageView!
    
    /// 定义模型属性
    var group : AuthorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            // 4 设置封面照片
            let imageURL = URL(string: (group?.icon_url)!)
            iconImageView.kf.setImage(with: imageURL)
        }
    }
}
