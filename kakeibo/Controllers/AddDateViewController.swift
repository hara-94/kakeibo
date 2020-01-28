//
//  AddDateViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/25.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class AddDateViewController: UIViewController {
    
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var endText: UITextField!
    var ADAccounts = [Account]()
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //datepickerの各種設定
        datePicker.datePickerMode = .date
        let startToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let endToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let startDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(startDone))
        let endDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endDone))
        startToolBar.setItems([spaceItem, startDoneItem], animated: true)
        endToolBar.setItems([spaceItem, endDoneItem], animated: true)
        startText.inputView = datePicker
        startText.inputAccessoryView = startToolBar
        endText.inputView = datePicker
        endText.inputAccessoryView = endToolBar
        
        //登録済みのAccountsの読み込み
        ADAccounts = Function.getAccounts()
        //viewdidloadここまで
        print("AD: view did load")
    }
    
    
    @objc func startDone() {
        startText.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        startText.text = formatter.string(from: datePicker.date)
    }
    
    @objc func endDone() {
        endText.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        endText.text = formatter.string(from: datePicker.date)
    }
    

    @IBAction func backButtonOnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonOnPressed(_ sender: Any) {
        if let start = startText.text {
            if let end = endText.text {
                if start != "" {
                    if end != "" {
                        let account = Account(startDate: start, endDate: end, expensePayments: [Payment](), incomePayments: [Payment]())
                        ADAccounts.append(account)
                        Function.setAccounts(object: ADAccounts)
                        dismiss(animated: true, completion: nil)
                    } else {
                        //endが空文字の場合
                        let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "終了時期を設定してください", preferredStyle: .alert)
                        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        present(alert, animated: true, completion: nil)
                    }
                } else {
                    //startが空文字の場合
                    let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "開始時期を設定してください", preferredStyle: .alert)
                    let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
}
