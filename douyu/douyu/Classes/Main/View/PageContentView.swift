//
//  PageContentView.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/9.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func PageContentViewDelegate(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}
private let ContentCellID = "ContentCellID"
class PageContentView: UIView {

    /// 自定义属性
    private var childViewControllers : [UIViewController]
    
    /// 弱引用修饰,否则跟HomeViewController循环强引用造成内存泄漏
    private weak var parentViewController : UIViewController?
    
    /// 滑动偏移量,用来确定左滑还是右滑
    private var startOffsetX : CGFloat = 0
    
    /// 是否禁止滑动代理,否则点击也会进入滑动代理没有必要，默认不禁止
    private var isForbidScrollDelegate : Bool = false
    
    /// 代理属性
    weak var delegate : PageContentViewDelegate?
    /// 懒加载属性 闭包引用self弱引用修饰
    private lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        // 强制解包
        layout.itemSize = (self?.bounds.size)!
        // 行间距
        layout.minimumLineSpacing = 0
        // 条目间距
        layout.minimumInteritemSpacing = 0
        // 滚动方向
        layout.scrollDirection = .horizontal
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        // 水平指示器关闭
        collectionView.showsHorizontalScrollIndicator = false
        // 分页显示
        collectionView.isPagingEnabled = true
        // 显示内容不超出显示区域
        collectionView.bounces = false
        // 设置collectionView的数据源
        collectionView.dataSource = self
        // 成为自己的代理,监听滚动
        collectionView.delegate = self
        // 自定义cell 必须得注册
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - frame: contentView
    ///   - childViewControllers: childViewControllers
    ///   - parentViewController: parentViewController
    
    init(frame: CGRect,childViewControllers:[UIViewController], parentViewController:UIViewController?) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI
extension PageContentView{
    private func initUI(){
        // 将所有的子控制器添加到父控制器中
        for  childvc in childViewControllers{
            parentViewController?.addChildViewController(childvc)
        }
        // 2. 添加UICollectionView,用于在Cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: -遵守UICollectionViewDataSource协议
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建我们的cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        // 给cell设置内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childCell = childViewControllers[indexPath.item]
        childCell.view.frame = CGRect(x: 0, y: 0, width: cell.contentView.bounds.width, height: cell.contentView.bounds.height)
        cell.contentView.addSubview(childCell.view)
        return cell
    }
}


// MARK: - 遵守UICollectionViewDelegate协议
extension PageContentView : UICollectionViewDelegate{
    // 开始滑动保存偏移量,用来知道是向左边滑动还是向右边滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        /// 一旦拖动就要执行滚动代理方法
        isForbidScrollDelegate =  false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// 0、判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        /// 1、定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
       
        /// 2、判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        if currentOffsetX > startOffsetX{
            // 表示左滑
            // 1、计算progress floor()取整函数
            progress = currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth)
            // 2、计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            // 3、计算targetIndex
            targetIndex = sourceIndex + 1
            // 判断目标index是否越界
            if targetIndex >= childViewControllers.count{
                targetIndex = childViewControllers.count - 1
            }
            // 4、如果完全滑动过去
            if currentOffsetX - startOffsetX == scrollViewWidth{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            // 表示右滑
            // 1、计算progress floor()取整函数
            let offset = currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth)
            progress = 1 - offset
            // 2、计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            // 3、计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewControllers.count{
                sourceIndex = childViewControllers.count - 1
            }
        }
        /// 3、将progress/sourceIndex/targetIndex传递给pageTitleView
        delegate?.PageContentViewDelegate(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
// MARK: -对外暴露方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        /// 记录需要禁止执行滑动代理方法
        isForbidScrollDelegate = true
        
        /// 滚动的正确的位置
        let offX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offX, y: 0), animated: false)
    }
}
