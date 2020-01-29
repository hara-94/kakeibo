//
//  ManageExpenseViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/28.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class ManageExpenseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryText: UITextField!
    var MEAccounts = [Account]()
    var MERowNumber: Int = 2
    var MECategories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
            

//        collectionView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        collectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "clCell")
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = cellLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        MEAccounts = Function.getAccounts()
            
        MECategories.removeAll()
        MECategories = MEAccounts[MERowNumber].expenseCategory
        collectionView.reloadData()
    }
        

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MECategories.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCell", for: indexPath) as! CategoryListCollectionViewCell
        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        cell.layer.borderColor = Function.buttonColor().cgColor
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .white
        cell.titleLabel.text = MECategories[indexPath.row]
        cell.titleLabel.textColor = Function.buttonColor()
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
                } else {
                    //登録済みの場合
                }
            }
        }
    }
}
