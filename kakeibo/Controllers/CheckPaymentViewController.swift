//
//  CheckPaymentViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/26.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class CheckPaymentViewController: UIViewController {
    
    var CPAccounts = [Account]()
    var CPRowNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CPAccounts = Function.getAccounts()
    }

}
