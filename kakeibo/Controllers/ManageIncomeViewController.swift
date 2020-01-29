//
//  ManageIncomeViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/28.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class ManageIncomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var incomeText: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var MIAccounts = [Account]()
    var MIRowNumber: Int = 0
    var MICategories = [String]()

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
        
        MIAccounts = Function.getAccounts()
        MICategories = MIAccounts[MIRowNumber].incomeCategory
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MICategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCell", for: indexPath) as! CategoryListCollectionViewCell
        cell.titleLabel.textColor = .white
        cell.backgroundColor = Function.cellColor()
        cell.titleLabel.text = MICategories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let cellSize = self.view.bounds.width / 3 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    @IBAction func addButtonOnPressed(_ sender: Any) {
        if let income = incomeText.text {
            if income != "" {
                if !MICategories.contains(income) {
                    MIAccounts[MIRowNumber].incomeCategory.append(income)
                    Function.setAccounts(object: MIAccounts)
                    MICategories = MIAccounts[MIRowNumber].incomeCategory
                    incomeText.text = ""
                    collectionView.reloadData()
                }
            }
        }
    }
    
}
