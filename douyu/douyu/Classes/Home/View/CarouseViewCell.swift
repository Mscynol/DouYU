//
//  CarouseViewCell.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/27.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
import Kingfisher
class CarouseViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    // 定义模型属性
    var carsouse : CarouseModel?{
        didSet{
            titleLabel.text = carsouse?.title
            let imageURL = URL(string: (carsouse?.pic_url)!)
            //iconImageView.kf.setImage(with: imageURL)
            let placeHolder = UIImage(named: "Img_default")
            iconImageView.kf.setImage(with: imageURL, placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    


