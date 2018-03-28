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
private let CarouselViewHeight : CGFloat = ScreenWidth * 3 / 8
private let HeadViewHeight : CGFloat = 50
private let NormalCellID = "NormalCellID"
private let PrettyCellID = "PrettyCellID"
private let HeaderView = "HeaderView"

/// 首页推荐控制器
class RecommendViewController: UIViewController {
    /// 懒加载属性
    private lazy var recommendViewModule : RecommendViewViewModel = RecommendViewViewModel()
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
    
    private lazy var recommendCarouselView : RecommendCarouseView = {
        let recommendCarouselView = RecommendCarouseView.recommendCarouselView()
        recommendCarouselView.frame = CGRect(x: 0, y: -CarouselViewHeight, width: ScreenWidth, height: CarouselViewHeight)
        return recommendCarouselView
    }()
    
    /// 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        // MARK: - 设置UI界面
        initUI()
        
        // MARK: - 发送网路请求
        loadData()
        
        // MARK: - 将recommendCarouselView添加到UICollectionView
        collectionView.addSubview(recommendCarouselView)
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: CarouselViewHeight, left: 0, bottom: 0, right: 0)
    
    }
}

// MARK: -  请求数据
extension RecommendViewController {
    private func loadData(){
        // 请求推荐数据
        recommendViewModule.requestData{
            self.collectionView.reloadData()
        }
        // 请求轮播图数据
        recommendViewModule.requestCarouseData{
            self.recommendCarouselView.carouseGroup = self.recommendViewModule.carouseGroup
        }
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModule.authorGroup.count
    }
    
    /// 每组有多少个数据源
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendViewModule.authorGroup[section]
        return group.authors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 0 取出模型对象
        let group = recommendViewModule.authorGroup[indexPath.section]
        let author = group.authors[indexPath.item]
        
        // 1 定义cell
        var cell : CollectionViewBasicCell
        
        // 3 取出cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath) as! CollectionViewPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionViewNormalCell
        }
        
        // 4 将我们的模型赋值给我们的cell
        cell.author = author
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView, for: indexPath) as! CollectionHeaderView
        //headerView.backgroundColor = UIColor.cyan
        // 取出数据头
        headerView.group = recommendViewModule.authorGroup[indexPath.section]
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
