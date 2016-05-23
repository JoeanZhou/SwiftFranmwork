//
//  TabBarView.swift
//  swiftframework
//
//  Created by ZhouXu on 19/5/16.
//  Copyright © 2016年 sichuangmingyi. All rights reserved.
//

import UIKit

class TabBarButton: UIButton {
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let image = self.imageForState(.Normal)
        if (image != nil) {
            let height = image?.size.height
            let width = image?.size.width
            let rc = CGRectMake((contentRect.size.width - width!) / 2.0, (contentRect.size.height - height! - 16.0) / 2.0, width!, height!)
            return rc
        }
        return super.imageRectForContentRect(contentRect)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(0.0, contentRect.size.height - 20.0, contentRect.size.width, 14.0)
    }
}

/**
 *  点击按钮的代理
 */
protocol TabBarDelegate : NSPortDelegate{
    func tabBarDidselected(tabBar : TabBarView, index : Int)
}


class TabBarView: UIView {
    weak var delegate : TabBarDelegate?
    private var buttonArray : [TabBarButton]?
    private var currentIndex : Int?
    private var currentButton : TabBarButton?
    private var iconArray : [String]?
    private var iconHeighArray : [String]?
    private var lineView : UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = RGBColor(248.0, green: 248.0, blue: 248.0, alpha: 0.9)
        lineView.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView)
        buttonArray = Array()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var rc = self.bounds
        lineView.frame = CGRectMake(0, 0, rc.width, 1)
        let buttonWidth = rc.size.width / CGFloat((buttonArray?.count)!)
        rc.size.width = buttonWidth
        for tabBarButton in buttonArray! {
            tabBarButton.frame = rc
            rc.origin.x += buttonWidth;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarView
{
    /**
     设置数据
     
     - parameter titleArray:     tabBar文字
     - parameter iconArray:      TabBar普通图片
     - parameter iconHeighArray: TabBar高亮文字
     */
    func setData(titleArray : [String], iconArray : [String], iconHeighArray : [String]){
        
        if titleArray.count != iconArray.count || titleArray.count != iconHeighArray.count {
            return;
        }
        self.iconArray = iconArray
        self.iconHeighArray = iconHeighArray
        let rc = CGRectZero
        var tag = 0
        for title in titleArray {
            let tabBarButton : TabBarButton = TabBarButton(type: .Custom)
            tabBarButton.frame = rc
            if let iconImage = UIImage(named: iconArray[tag]){
                tabBarButton.setImage(iconImage, forState: .Normal)
                tabBarButton.setImage(iconImage, forState: .Highlighted)
            }
            tabBarButton.setTitle(title, forState:.Normal)
            tabBarButton.setTitleColor(RGBColor(138, green: 138, blue: 138, alpha: 1.0), forState:.Normal)
            tabBarButton.addTarget(self, action: #selector(TabBarView.buttonPress(_:)), forControlEvents: .TouchUpInside)
            tabBarButton.titleLabel?.font = UIFont.systemFontOfSize(10.0)
            tabBarButton.titleLabel?.textAlignment = NSTextAlignment.Center
            tabBarButton.tag = tag
            tag += 1
            buttonArray?.append(tabBarButton)
            self.addSubview(tabBarButton)
        }
        self.setNeedsLayout()
    }
    
    /**
     选中哪个按钮
     
     - parameter index: 按钮的index
     */
    func selectedButton(index : Int){
        if index >= buttonArray?.count || index == currentIndex{
            return
        }
        if currentButton != nil {
            currentButton!.setTitleColor(RGBColor(138, green: 138, blue: 138, alpha: 1.0), forState:.Normal)
            if currentIndex < buttonArray?.count {
                if let iconImage = UIImage(named: iconArray![currentIndex!]) {
                    currentButton?.setImage(iconImage, forState: .Normal)
                    currentButton?.setImage(iconImage, forState: .Highlighted)
                }
            }
        }
        currentIndex = index
        if currentIndex < buttonArray?.count {
            currentButton = buttonArray![currentIndex!]
            currentButton?.setTitleColor(UIColor.blueColor(), forState: .Normal)
            if let iconImage = UIImage(named: iconHeighArray![currentIndex!]) {
                currentButton?.setImage(iconImage, forState: .Normal)
                currentButton?.setImage(iconImage, forState: .Highlighted)
            }
        }
    }
    
    @objc private func buttonPress(button : UIButton){
        selectedButton(button.tag)
        if delegate != nil {
            delegate?.tabBarDidselected(self, index: button.tag)
        }
    }
}
