//
//  RecommendGameView.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/28.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
private let RecommendGameViewID = "RecommendGameView"
private let GameViewEdgeInsets : CGFloat = 10.0
class RecommendGameView: UIView {

    var gameGroups : [AuthorGroup]?{
        didSet{
            // 移除前两组数据
            gameGroups?.removeFirst()
            gameGroups?.removeFirst()
            let moreGroup = AuthorGroup()
            moreGroup.tag_name = "更多"
            gameGroups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
         collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: RecommendGameViewID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: GameViewEdgeInsets, bottom: 0, right: GameViewEdgeInsets)
    }

}
// MARK: - 提供快速创建view的类方法
extension RecommendGameView{
    
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameGroups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendGameViewID, for: indexPath) as! CollectionViewGameCell
        //let group = gameGroups![indexPath.item]
        cell.group = gameGroups![indexPath.item]
        return cell
    }
}
