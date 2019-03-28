//
//  JsonModel.swift
//  RxSwift+Moya+HandyJson
//
//  Created by apple_mini on 2019/3/28.
//  Copyright © 2019年 Scode. All rights reserved.
//

import Foundation
import HandyJSON

struct RootClass: HandyJSON {
    var code: Int = 0
    var data: Data1?
    var msg: String?
}

struct Data1: HandyJSON {
    var info = [Info]()
    var count: Int = 0
}



struct Info: HandyJSON {
    var IrrStartNum: String?
    var IrrAreaName: String?
    var IrrFacilityStatus: String?
    var Endtime: String?
    var IrrFertAmount: String?
    var FertName: String?
    var IrrWaterAmount: String?
    var IrrRecordtime: String?
    var Starttime: String?
    var IrrAreaNo: Int = 0
    var Phenophase: String?
    var IrrSartMode: Int = 0
}
