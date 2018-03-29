//
//  CollectionViewGameCell.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/28.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewGameCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group : AuthorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
           // iconImageView.kf.setImage(with: URL(string: (group?.icon_url)!))
            iconImageView.kf.setImage(with: URL(string: (group?.icon_url)!), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
