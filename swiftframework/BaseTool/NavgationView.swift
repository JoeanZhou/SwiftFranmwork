//
//  NavgationView.swift
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


class NavgationView: UIView {

    var leftView : [UIView]?
    var rightView : [UIView]?
    var titleView : UIView?
    var titleColor : UIColor?
    fileprivate var titleLable : UILabel = UILabel()
    
    /**
     设置自定义titleView
     
     - parameter titleView1: 自定义的View
     - return : 返回设置好的View
     */
    func setCustomViewTitleView(_ titleView : UIView) -> UIView{
       return customViewTitleView(titleView)
    }
    
    /**
     设置左边的自定义View
     
     - parameter views: 装着View的数组
     */
    func setCustomViewLeftViews(_ views : [UIView]){
        customViewLeftViews(views)
    }
    
    /**
     设置右边的自定义View
     
     - parameter views: 装着View的数组
     */
    func setCustomViewRightViews(_ views : [UIView]){
        customViewRightViews(views)
    }
    
    /// 设置导航条文字
    var navTitle : String? {
        willSet{
           customViewWithTitle(newValue!)
        }
    }
    
    var bgImage : UIImage? {
        willSet{
            bgImageView?.image = newValue
        }
    }
    
    fileprivate var bgImageView : UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgImageView = UIImageView(frame: self.bounds)
        bgImageView!.backgroundColor = UIColor.orange
        addSubview(bgImageView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private let maginTop : CGFloat = 20
private let maginLeft : CGFloat = 15
extension NavgationView{
    
    func customViewWithTitle(_ title : String){
        titleLable.font = UIFont.systemFont(ofSize: 16.0)
        titleLable.text = title
        if titleColor != nil{
            titleLable.textColor = titleColor;
        }
        else{
            titleLable.textColor = UIColor.white
        }
        var rc = self.bounds
        titleLable.sizeToFit()
        rc.origin.x = (self.bounds.width - titleLable.frame.size.width) / CGFloat(2)
        rc.origin.y = maginTop
        rc.size.height = self.frame.size.height - maginTop
        
        var leftViewMaxX : CGFloat = 15
        if leftView?.count > 0 {
            for view in leftView! {
                leftViewMaxX += view.frame.size.width
            }
        }
        if leftViewMaxX > rc.origin.x {
            rc.size.width = self.bounds.width - leftViewMaxX * 2
            rc.origin.x = (self.bounds.width - rc.size.width) / CGFloat(2)
        }
        titleLable.frame = rc
        addSubview(titleLable)
    }
    
    fileprivate func customViewTitleView(_ titleView1 : UIView) -> UIView{
        if titleView != nil{
            titleView?.removeFromSuperview()
        }
        titleView = titleView1
        var leftMaxX : CGFloat = 0.0
        var count = 0
        let defaultX : CGFloat = (self.frame.size.width - (titleView?.frame.size.width)!) / 2.0
        self.addSubview(titleView!)
        if let arr = self.leftView{
            for view in arr {
                if count > 0 {
                    leftMaxX += view.frame.size.width
                }
                else{
                    leftMaxX = view.frame.origin.x
                }
                count += 1
            }
        }
        if leftMaxX > defaultX {
            titleView?.frame = CGRect(x: leftMaxX, y: titleView!.frame.origin.y + maginTop, width: (self.frame.size.width - leftMaxX * 2), height: self.frame.size.height - maginTop)
        }else{
            titleView?.frame = CGRect(x: defaultX, y: titleView!.frame.origin.y + maginTop, width: (self.frame.size.width - defaultX * 2), height: self.frame.size.height - maginTop)
        }
        return titleView!
    }
    
    fileprivate func customViewLeftViews(_ views : [UIView]){
        
        if views.count == 0{
            return
        }
        if leftView?.count > 0{
            for view in leftView! {
                view.removeFromSuperview()
            }
        }
        leftView?.removeAll()
        leftView = views
        var leftMaginX : CGFloat = 0
        var lastView : UIView?
        var count = 0
        for view in leftView! {
            self.addSubview(view)
            if (view is UIButton) || (view is UILabel){
                view.sizeToFit()
            }
            leftMaginX = (count == 0) ? maginLeft : (leftMaginX + lastView!.frame.size.width)
            view.frame = CGRect(x: leftMaginX, y: view.frame.origin.y + maginTop, width: view.frame.size.width, height: self.frame.size.height - maginTop)
            lastView = view
            count += 1
        }
    }
    
    fileprivate func customViewRightViews(_ views : [UIView]){
        if views.count == 0{
            return
        }
        if rightView?.count > 0{
            for view in rightView! {
                view.removeFromSuperview()
            }
        }
        rightView?.removeAll()
        rightView = views
        var leftMaginX : CGFloat = 0
        var count = 0
        for view in rightView! {
            let lastView = rightView![(rightView?.count)! - count - 1]
            if (lastView is UIButton) || (lastView is UILabel){
                lastView.sizeToFit()
            }
            if count > 0 {
                leftMaginX -= lastView.frame.size.width
            }else{
                leftMaginX = self.frame.size.width - lastView.frame.size.width
            }
            self.addSubview(view)

            view.frame = CGRect(x: leftMaginX, y: view.frame.origin.y + maginTop, width: view.frame.size.width, height: self.frame.size.height - maginTop)
            count += 1
        }
    }
}
