//
//  CHViewController.swift
//  chihuahua
//
//  Created by wbitos on 2018/11/12.
//  Copyright © 2018 wbitos. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

open class CHViewController: UIViewController {
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var backButton: UIButton = {
        let back = UIButton(type: .custom)
        back.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        back.setImage(CHBundle.shared.image(named: "navigation_back_indicator"), for: .normal)
        back.contentHorizontalAlignment = .left
        back.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (btn) in
            guard let strong = self else {
                return
            }
            strong.back(btn)
        }
        return back
    }()
    
    lazy open var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        closeButton.setImage(CHBundle.shared.image(named: "navigator_close"), for: .normal)
        closeButton.contentHorizontalAlignment = .left
        closeButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (btn) in
            guard let strong = self else {
                return
            }
            strong.navigationController?.popViewController(animated: true)
        }
        return closeButton
    }()
    
    lazy open var rightButton: UIButton = {
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightButton.contentHorizontalAlignment = .right
        rightButton.setTitleColor(UIColor(hex: 0xff5d34), for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return rightButton
    }()
    
    open var network: Bool {
        return false
    }
    
    open var enableDevToast: Bool {
        return true
    }
    
    open var viewDidLoadEvent: Closures.Action<CHViewController>? = nil
    open var viewWillAppearEvent: Closures.Action<CHViewController>? = nil
    open var viewDidAppearEvent: Closures.Action<CHViewController>? = nil
    open var viewWillDisappearEvent: Closures.Action<CHViewController>? = nil
    open var viewDidDisappearEvent: Closures.Action<CHViewController>? = nil

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.dynamicColor(light: .white, dark: .white)
        if let nav = self.navigationController {
            nav.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor(hex: 0x000000)
            ]
            
            if nav.viewControllers.count > 1 {
                self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: self.backButton)]
            }
        }
        self.viewDidLoadEvent?(self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        self.viewWillAppearEvent?(self)
        super.viewWillAppear(animated)
        weak var weakSelf = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = weakSelf
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppearEvent?(self)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        self.viewWillDisappearEvent?(self)
        super.viewWillDisappear(animated)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewDidDisappearEvent?(self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    open func reload(complete: Closures.Action<Bool>? = nil) {
        
    }
    
    @IBAction @objc dynamic open func back(_ sender: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NSLog("\(NSStringFromClass(self.classForCoder)) deinit ...")
    }
}

extension CHViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self) {
            return (self.navigationController?.viewControllers.count ?? 0) > 1
        }
        return true
    }
}
