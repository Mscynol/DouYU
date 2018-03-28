//
//  RecommendCarouseView.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/27.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

private let CarouseView : String = "CarouseView"
class RecommendCarouseView: UIView {
    
    var carouseTimer : Timer?
    
    var carouseGroup : [CarouseModel]?{
        didSet{
            // 刷新collectionview
            collectionView.reloadData()
            // 设置pageControl的个数
            pageControl.numberOfPages = (carouseGroup?.count) ?? 0
            // 默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (carouseGroup?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 添加定时器
            removeCarouseTimer()
            addCarouseTimer()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        autoresizingMask = []
        
        //collectionView.dataSource = self
        // 注册cell
        
        collectionView.register(UINib(nibName: "CarouseViewCell", bundle: nil), forCellWithReuseIdentifier: CarouseView)
        
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置collectionView layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenWidth * 3 / 8)
    }

}
// MARK: - 提供快速创建view的类方法
extension RecommendCarouseView{
    
    class func recommendCarouselView() -> RecommendCarouseView{
        return Bundle.main.loadNibNamed("RecommendCarouseView", owner: nil, options: nil)?.first as! RecommendCarouseView
    }
}

// MARK: - 遵守UICollectionView的数据协议
extension RecommendCarouseView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((carouseGroup?.count) ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouseView, for: indexPath) as! CarouseViewCell
        cell.carsouse = carouseGroup![indexPath.item % (carouseGroup?.count ?? 1)]
        return cell
    }
}

// MARK: - 遵守UICollectionView的代理协议
extension RecommendCarouseView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取滚动的偏移量
 //       let offX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 计算pageControl的currentIndex
//        print(Int(offX / scrollView.bounds.width))
//        pageControl.currentPage = Int(offX / scrollView.bounds.width)
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (carouseGroup?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 用户拖拽的时候移除定时器
        removeCarouseTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 用户不拖拽的时候增加定时器
        addCarouseTimer()
    }
}
extension RecommendCarouseView{
    private func addCarouseTimer(){
       carouseTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(carouseTimer!, forMode: .commonModes)
    }
    private func removeCarouseTimer(){
        carouseTimer?.invalidate() // 从运行状态中移除
        carouseTimer = nil
    }
    @objc private func scrollToNext(){
        // 获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        // 滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
