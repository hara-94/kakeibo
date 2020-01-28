//
//  TabBarViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/26.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var TBRowNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllers = self.viewControllers
        if let mpVC = viewControllers![0] as? ManagePaymentViewController {
            mpVC.MPRowNumber = TBRowNumber
        }
        if let clVC = viewControllers![1] as? CategoryListViewController {
            clVC.CLRowNumber = TBRowNumber
        }
        if let cpVC = viewControllers![2] as? CheckPaymentViewController {
            cpVC.CPRowNumber = TBRowNumber
        }
    }
    


}
