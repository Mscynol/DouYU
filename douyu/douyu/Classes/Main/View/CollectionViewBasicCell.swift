//
//  CollectionViewBasicCell.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/26.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewBasicCell: UICollectionViewCell {
    
    /// 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var onlineButton: UIButton!
    /// 定义模型属性
    var author : Author?{
        didSet{
            // 0 检验模型是否有值
            guard  let author = author else { return }
            // 1 取出在线人数
            var onlineNumbers : String = ""
            if author.online >= 10000{
                onlineNumbers = "\(Int(author.online / 10000))万在线"
            }else{
                onlineNumbers = "\(author.online)在线"
            }
            onlineButton.setTitle(onlineNumbers, for: .normal)
            // 2 显示昵称
            nickNameLabel.text = author.nickname
            
            // 4 设置封面照片
            let imageURL = URL(string: author.vertical_src)
            iconImageView.kf.setImage(with: imageURL)
            
        }
    }
}
