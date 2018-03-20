//
//  MainViewController.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/7.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
import Alamofire
class MainViewController: UITabBarController {
        
    /// 系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewFreeController(storaryName: "Home")
        addChildViewFreeController(storaryName: "Live")
        addChildViewFreeController(storaryName: "Follow")
        addChildViewFreeController(storaryName: "Profile")
        NetworkTools.requestData(type: .post, URLString: "http://httpbin.org/post", parameters: ["name":"Aisino"]) { (result) in
            print(result)
        }
    }
    
    /// 增加子View控制器
    ///
    /// - Parameter storaryName: 故事板名称
    private func addChildViewFreeController(storaryName:String){
        // 1、通过storyBoard获取控制器
        let childVC = UIStoryboard(name: storaryName, bundle: nil).instantiateInitialViewController()!
        // 2、将childVC最为字控制器
        addChildViewController(childVC)
    }

}
