//
//  Function.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/25.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import Foundation

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
    
}
