//
//  RecommendViewViewModel.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/20.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

class RecommendViewViewModel{
    // 2-12组数据
    lazy var authorGroup : [AuthorGroup] = [AuthorGroup]()
    // 推荐数据组
    private lazy var bigDataGroup : AuthorGroup = AuthorGroup()
    // 颜值数据
    private lazy var prettyDataGroup : AuthorGroup = AuthorGroup()
    // 轮播数据
    lazy var carouseGroup : [CarouseModel] = [CarouseModel]()
}

// MARK: - 请求网路数据
extension RecommendViewViewModel{
    func requestData(requestCompletedCallBack : @escaping () -> ()){
        // 0、定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime() as NSString]
        // 创建dispatch组
        let dispatchGroup = DispatchGroup()
        // 1、请求推荐数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getBigDataRoom", parameters: ["time":NSDate.getCurrentTime() as NSString]) { (result) in
            // 1,将result转字典类型
            guard let resultDict = result as? [String : Any] else { return }
            // 2、根据data该key,获取数组
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3、遍历字典，转换成模型对象
            // 3.1 设置组属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            // 获取主播数据
            for dict in dataArray{
                let author = Author(dict: dict)
                self.bigDataGroup.authors.append(author)
            }
            
            dispatchGroup.leave()
        }
        
        // 2、请求第二部分的颜值数据
        // http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1521537089
        dispatchGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1,将result转字典类型
            guard let resultDict = result as? [String : Any] else { return }
            // 2、根据data该key,获取数组
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3、遍历字典，转换成模型对象
            // 3.2 设置组属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_url = "columnYanzhiIcon"
            // 获取主播数据
            for dict in dataArray{
                let author = Author(dict: dict)
                self.prettyDataGroup.authors.append(author)
            }
            dispatchGroup.leave()
        }
        // 3、请求2-12后面其他部门游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1521537089
        dispatchGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters) { (result) in
            // 1,将result转字典类型
            guard let resultDict = result as? [String : Any] else { return }
            // 2、根据data该key,获取数组
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 3、遍历数组,获取字典，转换成模型对象
            for dict in dataArray{
                let group = AuthorGroup(dict: dict)
                self.authorGroup.append(group)
            }
            dispatchGroup.leave()
        }
        
        // 所有数据请求完毕后 排序
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.authorGroup.insert(self.prettyDataGroup, at: 0)
            self.authorGroup.insert(self.bigDataGroup, at: 0)
            requestCompletedCallBack()
        }
        
    }
    func requestCarouseData(requestCompleteCallBack : @escaping () -> ()){
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "3.710"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else { return }
            // 根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{ return }
            
            // 字典转模型
            for dict in dataArray{
                self.carouseGroup.append(CarouseModel(dict: dict))
            }
            
            requestCompleteCallBack()
        }
        
    }
}
