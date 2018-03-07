//
//  MainViewController.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/7.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewFreeController(storaryName: "Home")
        addChildViewFreeController(storaryName: "Live")
        addChildViewFreeController(storaryName: "Follow")
        addChildViewFreeController(storaryName: "Profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
