//
//  CategoryListViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/26.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var CLAccounts = [Account]()
    var CLRowNumber: Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        collectionView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CLAccounts = Function.getAccounts()
        print(CLRowNumber)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        return cell
    }
}
