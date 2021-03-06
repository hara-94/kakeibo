//
//  CategoryListViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/26.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var categoryText: UITextField!
    
    var CLAccounts = [Account]()
    var CLRowNumber: Int = 2
    var CLCategories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Function.viewColor()
        collectionView.backgroundColor = Function.viewColor()
        collectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "clCell")
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = cellLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CLAccounts = Function.getAccounts()
        
        CLCategories.removeAll()
        CLCategories = CLAccounts[CLRowNumber].expenseCategory
        collectionView.reloadData()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CLCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCell", for: indexPath) as! CategoryListCollectionViewCell
        cell.titleLabel.textColor = .white
        cell.titleLabel.text = CLCategories[indexPath.row]
        cell.backgroundColor = Function.cellColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = self.view.bounds.width / 3 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    @IBAction func addButtonOnPressed(_ sender: Any) {
        if let category = categoryText.text {
            if category != "" {
                if !CLCategories.contains(category) {
                    CLAccounts[CLRowNumber].expenseCategory.append(category)
                    Function.setAccounts(object: CLAccounts)
                    CLCategories = CLAccounts[CLRowNumber].expenseCategory
                    collectionView.reloadData()
                } else {
                    //登録済みの場合
                }
            }
        }
    }
}
