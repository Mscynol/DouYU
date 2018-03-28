//
//  PageTitleView.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/8.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

/// 代理协议只能被类遵守
protocol PageTitleViewDelegate : class{
    func PageTitleViewDelegate(titleView : PageTitleView, selectedIndex index : Int)
}
/// 定义常量
/// 滑动轴的高度
private let ScrollLineHeight:CGFloat = 2
private let NormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let SelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
class PageTitleView: UIView {
    
    
    /// 定义标题属性
    private var titles:[String]
    private var currentLabelIndex : Int = 0
    
    /// 代理属性必须遵守这个协议 用weak
    weak var delegate : PageTitleViewDelegate?
    /// 定义懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        // 关闭
        scrollView.scrollsToTop = false
        // 设置scrollView的内容不超过屏幕内容区
        scrollView.bounces = false
        return scrollView
        
    }()
    
    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - frame: 页面
    ///   - titles: 标题栏名称数组
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        // 1 > 设置标题栏UI
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置标题栏UI
extension PageTitleView{
    private func initUI(){
        // 1 > 添加UIScrollView
        addSubview(scrollView)
        // 设置自定义scrollview的大小宽高
        scrollView.frame = bounds
        // 2 > 添加title对应的Label
        initTitleLabels()
        // 3 > 设置底线及滚动滑块
        initBottomLineAndScrollLine()
    }
    private func initTitleLabels(){
        // 确定label的常量值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - ScrollLineHeight
        let labelY:CGFloat = 0
        
        for(index,title) in titles.enumerated(){
            // 1 > 创建UILabel
            let label = UILabel()
            // 2 > 设置Label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
            label.textAlignment = .center
            // 3 > 设置Label的frame
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 4 > 将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            // 5 > label添加手势
            label.isUserInteractionEnabled = true
            // 点击手势
            
           // let tapGes = UITapGestureRecognizer(target: self, action: #selector(PageTitleView.titleLabelClick(_:)))
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tagGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func initBottomLineAndScrollLine(){
        // 1 > 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineHeight:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineHeight, width: frame.width, height: bottomLineHeight)
        addSubview(bottomLine)
        
        // 2 > 添加scrollLine
        // 2.1 > 拿到第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: SelectedColor.0, g: SelectedColor.1, b: SelectedColor.2)
        // 2.2 > 设置bottomLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - ScrollLineHeight, width: firstLabel.frame.width, height: ScrollLineHeight)
        
        
    }
}

// MARK: - 监听Label的点击事件
extension PageTitleView{
    @objc private func titleLabelClick(tagGes : UITapGestureRecognizer){
        // 0.  获取当前label
         guard let currentLabel = tagGes.view as?UILabel else { return }
        
        // 1. 如果是重复点击同一个Title
        if currentLabel.tag == currentLabelIndex { return }
        
        // 2.获取之前的label
        let beforeTapGesLabel = titleLabels[currentLabelIndex]
        
        // 3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: SelectedColor.0, g: SelectedColor.1, b: SelectedColor.2)
        beforeTapGesLabel.textColor = UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
        
        // 4. 保存最新Label的下标值
        currentLabelIndex = currentLabel.tag
        
        // 5. 滑动条位置跟随点击事件移动
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2){
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        // 6. 通知代理
        delegate?.PageTitleViewDelegate(titleView: self, selectedIndex: currentLabelIndex)
    }
}

// MARK: - 对外暴露方法
extension PageTitleView{
    func setTitleViewWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        // 1、取出sourceIndex / targetIndex 的Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        // 2、处理滑块渐变
        let scrollTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let scrollX = scrollTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + scrollX
        // 3、颜色的渐变
        // 3.1 取出变化的范围 类型推导
        let colorRange = (SelectedColor.0 - NormalColor.0,SelectedColor.1 - NormalColor.1,SelectedColor.2 - NormalColor.2)
        
        // 3.2 变化sourceLabel的颜色
        sourceLabel.textColor = UIColor(r: SelectedColor.0 - colorRange.0 * progress, g: SelectedColor.1 - colorRange.1 * progress, b: SelectedColor.2 - colorRange.2 * progress)
        
        // 3.3 变化tartgetLabel的颜色
        targetLabel.textColor = UIColor(r: NormalColor.0 + colorRange.0 * progress, g: NormalColor.1 + colorRange.1 * progress, b: NormalColor.2 + colorRange.2 * progress)
        
        /// 4、记录最新的index
        currentLabelIndex = targetIndex
        
    }
}
