//
//  Payment.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/27.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import Foundation

class Payment: NSObject, NSCoding {
    
    var content: String
    var money: String
    
    init(content: String, money: String) {
        self.content = content
        self.money = money
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(content, forKey: "content")
        coder.encode(money, forKey: "money")
    }
    
    required init?(coder: NSCoder) {
        content = coder.decodeObject(forKey: "content") as! String
        money = coder.decodeObject(forKey: "money") as! String
    }
}
