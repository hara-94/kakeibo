//
//  ManageIncomeViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/28.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class ManageIncomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    var MIAccounts = [Account]()
    var MIRowNumber: Int = 0
    var MICategories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryText.delegate = self
        gestureRecognizer.delegate = self

        collectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "clCell")
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = cellLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MIAccounts = Function.getAccounts()
        MICategories = MIAccounts[MIRowNumber].incomeCategory
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MICategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCell", for: indexPath) as! CategoryListCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = Function.buttonColor().cgColor
        cell.layer.cornerRadius = 10
        cell.titleLabel.text = MICategories[indexPath.row]
        cell.titleLabel.textColor = Function.buttonColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let cellSize = self.view.bounds.width / 3 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        categoryText.resignFirstResponder()
    }
    
    @IBAction func addButtonOnPressed(_ sender: Any) {
        if let income = categoryText.text {
            if income != "" {
                if !MICategories.contains(income) {
                    MIAccounts[MIRowNumber].incomeCategory.append(income)
                    Function.setAccounts(object: MIAccounts)
                    MICategories = MIAccounts[MIRowNumber].incomeCategory
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
    
    
    @IBAction func endEditing(_ sender: Any) {
        categoryText.resignFirstResponder()
    }
    
}
