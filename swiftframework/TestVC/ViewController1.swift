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
        view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
        let button : UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 230, height: 50)
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitle("这是自定义的View 点我啊", for: UIControlState())
        button.addTarget(self, action:#selector(ViewController1.testPush), for: .touchUpInside)
        button.backgroundColor = UIColor.red
        navView?.setCustomViewTitleView(button)
        
        let buttonLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        buttonLeft.setImage(UIImage(named: "tab_chance_pressed"), for: UIControlState())
        navView?.setCustomViewLeftViews([buttonLeft])
    }
    
    func testPush(){
        let vc = PushTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
