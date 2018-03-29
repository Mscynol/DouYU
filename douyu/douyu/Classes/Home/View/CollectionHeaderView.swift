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
            // 4 设置头部图片
            if verifyUrl(str: (group?.small_icon_url)!){
                iconImageView.kf.setImage(with: URL(string:(group?.small_icon_url)!))
            }else{
                iconImageView.image = UIImage(named: group?.small_icon_url ?? "home_header_normal")
            }
            
        }
    }
}

// MARK: - 校验是否连接是URL
extension CollectionHeaderView{
    
    private func verifyUrl(str:String) -> Bool {
        //创建NSURL实例
        if let url = NSURL(string: str) {
            //检测应用是否能打开这个NSURL实例
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
