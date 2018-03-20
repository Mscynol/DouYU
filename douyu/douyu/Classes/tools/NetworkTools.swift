//
//  NetworkTools.swift
//  douyu
//
//  Created by 张小帅 on 2018/3/19.
//  Copyright © 2018年 com.mscynol.study. All rights reserved.
//

import UIKit
import Alamofire

/// 网络工具类
class NetworkTools{
    enum MethodType {
        case get
        case post
    }
    class func requestData(type : MethodType,URLString : String, parameters : [String : NSString]? = nil,completedCallBack : @escaping (_ result : AnyObject) ->()) {
        /// 获取类型
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post

        /// 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON{ (response:DataResponse)in
            switch(response.result){
            case .success(_):
                if let data = response.result.value {
                    completedCallBack(data as AnyObject)
                }
                break
            case .failure(_):
                print("网络请求返回失败:\(response.result.error ?? "error" as! Error)")
            }
        }
    }
}
