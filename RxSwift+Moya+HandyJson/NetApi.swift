//
//  NetApi.swift
//  RxSwift+Moya+HandyJson
//
//  Created by apple_mini on 2019/3/28.
//  Copyright © 2019年 Scode. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result


//http://47.99.63.13/qifeng/Voyages/selectinfos?area_no=3


enum NetApi{
    case getJson(String)
}

let ApiProvider = MoyaProvider<NetApi>(requestClosure: timeoutClosure)

let ApiLoadingProvider = MoyaProvider<NetApi>(requestClosure: timeoutClosure, plugins: [NetPlugin()])

let ApiSampleProvider = MoyaProvider<NetApi>(plugins:[NetPlugin()])




let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    
    switch type {
    case .began:
        print("began")
    case .ended:
        print("ended")
    }
}

class NetPlugin: PluginType{
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        print("plugin prepare:\(request)")
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("plugin willsend:\(request)")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        print("plugin didreceive:\(result)")
    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        print("plugin process:\(result)")
          return result
    }
    
    
    
}


let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<NetApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}


extension NetApi: TargetType{
  
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    
    var baseURL: URL {
        switch self{
        case .getJson(_):
            return URL(string: "http://47.99.63.13/qifeng")!
        }
    }
    
    var path: String {
        switch self {
        case.getJson(_):
            return "Voyages/selectinfos"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getJson(_):
            return .get
        default:
            return .get
        }
    }
    
 
    
    var task: Task {
        switch self {
        case .getJson(let code):
            return .requestParameters(parameters: ["area_no":code], encoding: URLEncoding.default)
        default:
            return .requestPlain //表示为空
        }
    }
    
    var headers: [String : String]? {
         return ["Content-type" : "application"]
    }
    
}


