//
//  TabBarView.swift
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

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class TabBarButton: UIButton {
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let image = self.image(for: UIControlState())
        if (image != nil) {
            let height = image?.size.height
            let width = image?.size.width
            let rc = CGRect(x: (contentRect.size.width - width!) / 2.0, y: (contentRect.size.height - height! - 16.0) / 2.0, width: width!, height: height!)
            return rc
        }
        return super.imageRect(forContentRect: contentRect)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0.0, y: contentRect.size.height - 20.0, width: contentRect.size.width, height: 14.0)
    }
}

/**
 *  点击按钮的代理
 */
protocol TabBarDelegate : PortDelegate{
    func tabBarDidselected(_ tabBar : TabBarView, index : Int)
}


class TabBarView: UIView {
    weak var delegate : TabBarDelegate?
    fileprivate var buttonArray : [TabBarButton]?
    fileprivate var currentIndex : Int?
    fileprivate var currentButton : TabBarButton?
    fileprivate var iconArray : [String]?
    fileprivate var iconHeighArray : [String]?
    fileprivate var lineView : UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = RGBColor(248.0, green: 248.0, blue: 248.0, alpha: 0.9)
        lineView.backgroundColor = UIColor.lightGray
        addSubview(lineView)
        buttonArray = Array()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var rc = self.bounds
        lineView.frame = CGRect(x: 0, y: 0, width: rc.width, height: 1)
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
    func setData(_ titleArray : [String], iconArray : [String], iconHeighArray : [String]){
        
        if titleArray.count != iconArray.count || titleArray.count != iconHeighArray.count {
            return;
        }
        self.iconArray = iconArray
        self.iconHeighArray = iconHeighArray
        let rc = CGRect.zero
        var tag = 0
        for title in titleArray {
            let tabBarButton : TabBarButton = TabBarButton(type: .custom)
            tabBarButton.frame = rc
            if let iconImage = UIImage(named: iconArray[tag]){
                tabBarButton.setImage(iconImage, for: UIControlState())
                tabBarButton.setImage(iconImage, for: .highlighted)
            }
            tabBarButton.setTitle(title, for:UIControlState())
            tabBarButton.setTitleColor(RGBColor(138, green: 138, blue: 138, alpha: 1.0), for:UIControlState())
            tabBarButton.addTarget(self, action: #selector(TabBarView.buttonPress(_:)), for: .touchUpInside)
            tabBarButton.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
            tabBarButton.titleLabel?.textAlignment = NSTextAlignment.center
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
    func selectedButton(_ index : Int){
        if index >= buttonArray?.count || index == currentIndex{
            return
        }
        if currentButton != nil {
            currentButton!.setTitleColor(RGBColor(138, green: 138, blue: 138, alpha: 1.0), for:UIControlState())
            if currentIndex < buttonArray?.count {
                if let iconImage = UIImage(named: iconArray![currentIndex!]) {
                    currentButton?.setImage(iconImage, for: UIControlState())
                    currentButton?.setImage(iconImage, for: .highlighted)
                }
            }
        }
        currentIndex = index
        if currentIndex < buttonArray?.count {
            currentButton = buttonArray![currentIndex!]
            currentButton?.setTitleColor(UIColor.blue, for: UIControlState())
            if let iconImage = UIImage(named: iconHeighArray![currentIndex!]) {
                currentButton?.setImage(iconImage, for: UIControlState())
                currentButton?.setImage(iconImage, for: .highlighted)
            }
        }
    }
    
    @objc fileprivate func buttonPress(_ button : UIButton){
        selectedButton(button.tag)
        if delegate != nil {
            delegate?.tabBarDidselected(self, index: button.tag)
        }
    }
}
