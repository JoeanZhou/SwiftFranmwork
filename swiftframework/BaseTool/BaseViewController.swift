//
//  BaseViewController.swift
//  swiftframework
//
//  Created by ZhouXu on 19/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit

class NavBackButton: UIButton {
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let image = self.imageForState(.Normal)
        if (image != nil) {
            let height = image?.size.height
            let width = image?.size.width
            let rc = CGRectMake(0, (contentRect.size.height - height!) / 2.0, width!, height!)
            return rc
        }
        return super.imageRectForContentRect(contentRect)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(contentRect.origin.x + 2, contentRect.origin.y, contentRect.size.width, contentRect.size.height)
    }
}

class BaseViewController: UIViewController {

    var navView : NavgationView?
    var navTitle : String?{
        willSet{
            navView?.navTitle = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navView = NavgationView(frame: CGRectMake(0, 0, view.bounds.size.width, 64))
        view.addSubview(navView!)
        
        addCustomBackButton()
    }
    
    func addCustomBackButton(){
        if navigationController?.viewControllers.count > 1 {
            let button = getBackButton()
            navView?.setCustomViewLeftViews([button])
        }
    }
    
    func getBackButton() -> UIButton{
        let button = NavBackButton(type: .Custom)
        button.setImage(UIImage(named: "icon_back"), forState: .Normal)
        button.setTitle("返回", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.frame = CGRectMake(0, 0, 50, 50);
        button.addTarget(self, action: #selector(BaseViewController.goBack(_:)), forControlEvents: .TouchUpInside)
        return button
    }
    
    func goBack(sender : UIButton){
        navigationController?.popViewControllerAnimated(true)
    }
}
