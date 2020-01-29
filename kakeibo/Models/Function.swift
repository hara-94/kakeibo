//
//  Function.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/25.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class Function {
    
    class func getAccounts() -> [Account] {
        var accounts = [Account]()
        if let storedAccountsData = UserDefaults.standard.data(forKey: "accountsData") {
            if let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedAccountsData) as? [Account] {
                accounts = decodedData
            }
        }
        return accounts
    }
    
    class func setAccounts(object: [Account]) {
        if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) {
            UserDefaults.standard.set(encodedData, forKey: "accountsData")
        }
    }
    
    class func viewColor() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
    }
    
    class func cellColor() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 30/255, alpha: 1)
    }
    
    class func buttonColor() -> UIColor {
        return UIColor(red: 244/255, green: 178/255, blue: 81/255, alpha: 1)
    }
    
}
