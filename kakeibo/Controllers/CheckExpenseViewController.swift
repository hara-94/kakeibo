//
//  CheckExpenseViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/29.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class CheckExpenseViewController: UIViewController {
    
    var CEAccounts = [Account]()
    var CEIndex: Int = 0
    var CEExpensePayments = [Payment]()
    var CETitle: String = ""
    var CEInfo = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CEAccounts = Function.getAccounts()
//        CEIndex = CEInfo["index"] as! Int
        print(CEInfo)
        CEExpensePayments = CEAccounts[CEIndex].expensePayments
    }
    
}
