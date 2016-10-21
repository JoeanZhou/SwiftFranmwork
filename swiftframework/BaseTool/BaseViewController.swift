//
//  BaseViewController.swift
//  swiftframework
//
//  Created by ZhouXu on 19/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class NavBackButton: UIButton {
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let image = self.image(for: UIControlState())
        if (image != nil) {
            let height = image?.size.height
            let width = image?.size.width
            let rc = CGRect(x: 0, y: (contentRect.size.height - height!) / 2.0, width: width!, height: height!)
            return rc
        }
        return super.imageRect(forContentRect: contentRect)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.origin.x + 2, y: contentRect.origin.y, width: contentRect.size.width, height: contentRect.size.height)
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
        
        navView = NavgationView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
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
        let button = NavBackButton(type: .custom)
        button.setImage(UIImage(named: "icon_back"), for: UIControlState())
        button.setTitle("返回", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
        button.addTarget(self, action: #selector(BaseViewController.goBack(_:)), for: .touchUpInside)
        return button
    }
    
    func goBack(_ sender : UIButton){
        navigationController?.popViewController(animated: true)
    }
}
