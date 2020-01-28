//
//  Account.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/25.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import Foundation

class Account: NSObject, NSCoding {
    
    var startDate: String
    var endDate: String
    var expensePayments: [Payment]
    var incomePayments: [Payment]
    
    init(startDate: String, endDate: String, expensePayments: [Payment], incomePayments: [Payment]) {
        self.startDate = startDate
        self.endDate = endDate
        self.expensePayments = expensePayments
        self.incomePayments = incomePayments
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(startDate, forKey: "stardDate")
        coder.encode(endDate, forKey: "endDate")
        coder.encode(expensePayments, forKey: "expensePayments")
        coder.encode(incomePayments, forKey: "incomePayments")
    }
    
    required init?(coder: NSCoder) {
        startDate = coder.decodeObject(forKey: "stardDate") as! String
        endDate = coder.decodeObject(forKey: "endDate") as! String
        expensePayments = coder.decodeObject(forKey: "expensePayments") as! [Payment]
        incomePayments = coder.decodeObject(forKey: "incomePayments") as! [Payment]
    }
}
