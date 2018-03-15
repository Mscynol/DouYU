//
//  RecommendViewController.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/14.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

/// 定义常量属性
private let ItemMargin : CGFloat = 10
private let ItemWidth : CGFloat = (ScreenWidth - (3 * ItemMargin)) / 2
private let ItemNormalHeight : CGFloat = ItemWidth * 3 / 4
private let ItemPrettyHeight : CGFloat = ItemWidth * 4 / 3
private let HeadViewHeight : CGFloat = 50
private let NormalCellID = "NormalCellID"
private let PrettyCellID = "PrettyCellID"
private let HeaderView = "HeaderView"

/// 首页推荐控制器
class RecommendViewController: UIViewController {
    /// 懒加载属性
    private lazy var collectionView : UICollectionView = { [unowned self] in
        
        /// 创建uicollectionView布局
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        /// 设置uicollectionView item 行间距
        collectionViewLayout.minimumLineSpacing = 0
        /// 设置uicollectionView item 相邻间距
        collectionViewLayout.minimumInteritemSpacing = ItemMargin
        /// 设置组的内边距
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: ItemMargin, bottom: 0, right: ItemMargin)
        /// 设置组头
        collectionViewLayout.headerReferenceSize = CGSize(width: ItemWidth, height: HeadViewHeight)
       
        
        /// UICollectionView 布局的大小
        collectionViewLayout.itemSize = CGSize(width: ItemWidth, height: ItemNormalHeight)
        
        /// 创建uicollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.white
        
        /// 让控制器成为uicollectionView的数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        /// 设置collectionView大小自动随父控件伸缩
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        /// 注册CellID
       // collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: NormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: PrettyCellID)
        /// 注册头部View
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderView)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderView)
        return collectionView
    }()
    
    /// 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        // MARK: - 设置UI界面
        initUI()
    
    }
}

// MARK: - 进行扩展设置推荐界面
extension RecommendViewController {
    
    /// 设置UI
    private func initUI(){
        /// 将UICollectionView添加到vIEW的控制器中
        view.addSubview(collectionView)
    }
}

/// MARK: - 遵守UICollectionViewdataSource数据协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 有分组的话实现该协议 一共有多少个组
    ///
    /// - Parameter collectionView: <#collectionView description#>
    /// - Returns: <#return value description#>
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    /// 每组有多少个数据源
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }else{
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1、获取我们的Cell
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath)
        var cell : UICollectionViewCell!
        // 取出cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView, for: indexPath)
        //headerView.backgroundColor = UIColor.cyan
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: ItemWidth, height: ItemPrettyHeight)
        }else{
            return CGSize(width: ItemWidth, height: ItemNormalHeight)
        }
    }
}
