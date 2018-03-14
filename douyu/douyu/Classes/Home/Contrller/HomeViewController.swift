//
//  HomeViewController.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/8.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
private let pageTitleViewHeight:CGFloat = 40
class HomeViewController: UIViewController {

    /// 懒加载属性
    private lazy var pageTitleView:PageTitleView={[weak self] in
        
        /// 设置首页标题栏的宽度高度
        let titleFrame = CGRect(x: 0, y: StatusBarHeight + NavigationBarHeight, width: ScreenWidth, height: pageTitleViewHeight)
        
        /// 设置首页标题栏的文字
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        // 设置首页内容区的高度宽度
        let contentViewHeight = ScreenHeight - StatusBarHeight - NavigationBarHeight - pageTitleViewHeight
        let contentViewFrame = CGRect(x: 0, y: StatusBarHeight + NavigationBarHeight + pageTitleViewHeight, width: ScreenWidth, height: contentViewHeight)
        // 确定所有的子控制器
        var childVCS = [UIViewController]()
        for _ in 0..<4 {
           let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCS.append(vc)
        }
        let contentView = PageContentView(frame: contentViewFrame, childViewControllers: childVCS, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()

    /// 系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        initUI();
    }
}

// MARK: - 设置首页UI界面
extension HomeViewController{
    private func initUI(){
        // 0 、不需要调整scrollView 的内边距
        // automaticallyAdjustsScrollViewInsets = false
        // 1、设置导航栏
        initNavigationBar()
        // 2、添加titleView
        view.addSubview(pageTitleView)
        // 3、添加pageContenView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    private func initNavigationBar(){
        // 1、设置左侧导航栏item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2、设置右侧导航栏item
        let size = CGSize(width: 40, height: 40);
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highLightImageName: "Image_my_history_click", imageSize: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highLightImageName: "btn_search_clicked", imageSize: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highLightImageName: "Image_scan_click", imageSize: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}


// MARK: - 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate{
    func PageTitleViewDelegate(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK: - 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate{
    func PageContentViewDelegate(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleViewWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
