//
//  ManageExpenseViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/28.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class ManageExpenseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    var MEAccounts = [Account]()
    var MERowNumber: Int = 2
    var MECategories = [String]()
    var MEExpensePayments = [Payment]()
    var MEInfo = [String: Any]()
    var METitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryText.delegate = self
        gestureRecognizer.delegate = self
        
        collectionView.register(UINib(nibName: "ManageExpenseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "meCell")
        collectionView.delegate = self
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = cellLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        MEAccounts = Function.getAccounts()
            
        MECategories.removeAll()
        MECategories = MEAccounts[MERowNumber].expenseCategory
        MEExpensePayments = MEAccounts[MERowNumber].expensePayments
        collectionView.reloadData()
        
        gestureRecognizer.cancelsTouchesInView = false
    }
        

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MECategories.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meCell", for: indexPath) as! ManageExpenseCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = Function.buttonColor().cgColor
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .white
        let title = MECategories[indexPath.row]
        cell.titleLabel.text = title
        cell.titleLabel.textColor = Function.buttonColor()
        var totalMoney: Int = 0
        for payment in MEExpensePayments {
            if payment.content == title {
                if let intMoney = Int(payment.money) {
                    totalMoney = totalMoney + intMoney
                }
            }
        }
        cell.moneyLabel.text = String(totalMoney) + "円"
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let cellSize = self.view.bounds.width / 3 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
    
    @IBAction func addButtonOnPressed(_ sender: Any) {
        if let category = categoryText.text {
            if category != "" {
                if !MECategories.contains(category) {
                    MEAccounts[MERowNumber].expenseCategory.append(category)
                    Function.setAccounts(object: MEAccounts)
                    MECategories = MEAccounts[MERowNumber].expenseCategory
                    categoryText.text = ""
                    collectionView.reloadData()
                    categoryText.endEditing(true)
                } else {
                    //登録済みの場合
                    let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "この項目は登録済みです", preferredStyle: .alert)
                    let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        self.categoryText.text = ""
                    }
                    alert.addAction(OKAction)
                    present(alert, animated: true, completion: nil)
                }
            } else {
                //文字列が空
                let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "カテゴリー名を記入してください", preferredStyle: .alert)
                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        categoryText.resignFirstResponder()
    }
    
}
