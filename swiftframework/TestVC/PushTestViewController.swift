//
//  PushTestViewController.swift
//  swiftframework
//
//  Created by ZhouXu on 20/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit

class PushTestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navTitle = "这是push的控制器 你有种再点啊"
        navView?.setCustomViewRightViews([getBackButton()])
        
        navView?.bgImage = UIImage(named: "tab_chance_pressed")
    }
}
