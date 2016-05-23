//
//  BaseNavigationViewController.swift
//  swiftframework
//
//  Created by ZhouXu on 19/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
    }
}
