//
//  Moya+Extension.swift
//  RxSwift+Moya+HandyJson
//
//  Created by apple_mini on 2019/3/28.
//  Copyright © 2019年 Scode. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import RxSwift


extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type)  -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapModel(T.self))
        }
    }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
            //            throw RxSwiftMoyaError.ParseJSONError
        }
        return model
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }
