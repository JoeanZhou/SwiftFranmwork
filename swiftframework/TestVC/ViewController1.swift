//
//  ViewController1.swift
//  swiftframework
//
//  Created by ZhouXu on 19/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit

class ViewController1: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellowColor()
        // Do any additional setup after loading the view.
        let button : UIButton = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 230, 50)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitle("这是自定义的View 点我啊", forState: .Normal)
        button.addTarget(self, action:#selector(ViewController1.testPush), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.redColor()
        navView?.setCustomViewTitleView(button)
        
        let buttonLeft = UIButton(frame: CGRectMake(0, 0, 30, 30))
        buttonLeft.setImage(UIImage(named: "tab_chance_pressed"), forState: .Normal)
        navView?.setCustomViewLeftViews([buttonLeft])
    }
    
    func testPush(){
        let vc = PushTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
