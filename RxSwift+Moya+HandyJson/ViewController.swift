//
//  ViewController.swift
//  RxSwift+Moya+HandyJson
//
//  Created by apple_mini on 2019/3/28.
//  Copyright © 2019年 Scode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
    ApiLoadingProvider.rx.request(.getJson("3")).asObservable().mapModel(RootClass.self).subscribe(onNext: { (model) in
            print(model)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disbag)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

