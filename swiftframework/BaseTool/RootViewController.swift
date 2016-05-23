//
//  RootViewController.swift
//  swiftframework
//
//  Created by ZhouXu on 19/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController, TabBarDelegate{

    private let tabBarHeight : CGFloat = 50
    var currentIndex : Int = 0
    var currentView : UIView?
    var vc1 : ViewController1 = ViewController1()
    var vc2 : ViewController2 = ViewController2()
    var vc3 : ViewController3 = ViewController3()
    var vc4 : ViewController4 = ViewController4()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarView : TabBarView = TabBarView(frame: CGRectMake(0, view.bounds.size.height - tabBarHeight, view.bounds.size.width, tabBarHeight))
        tabBarView.delegate = self
        view.addSubview(tabBarView)
        tabBarView.setData(["首页", "发现", "圈子", "我"],
                           iconArray: ["tab_chance" ,"tab_chance", "tab_chance", "tab_chance"], iconHeighArray: ["tab_chance_pressed" ,"tab_chance_pressed", "tab_chance_pressed", "tab_chance_pressed"])
        
        addChildViewController(vc1)
        addChildViewController(vc2)
        addChildViewController(vc3)
        addChildViewController(vc4)
        
        tabBarView.selectedButton(0)
        showNewController(0)
    }
    
    func tabBarDidselected(tabBar: TabBarView, index: Int) {
        if currentIndex == index {
            return
        }
        if index < childViewControllers.count {
            if currentIndex != index{
                currentView?.removeFromSuperview()
            }
            currentIndex = index
            showNewController(currentIndex)
        }
    }
    
    
    func showNewController(index : Int){
        if index < childViewControllers.count {
            let vc : UIViewController = childViewControllers[index]
            vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - tabBarHeight - 0);
            currentView = vc.view;
            view.addSubview(vc.view)
        }
    }
}
