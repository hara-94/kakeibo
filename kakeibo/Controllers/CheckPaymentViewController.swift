//
//  CheckPaymentViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/26.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class CheckPaymentViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var CPAccounts = [Account]()
    var CPRowNumber: Int = 0
    var CPExpensePayments = [Payment]()
    var CPIncomePayments = [Payment]()
    var expenseTotalMoney: Int = 0
    var incomeTotalMoney: Int = 0
    let scrollView = UIScrollView()
    let expenseTableView = UITableView()
    let incomeTableView = UITableView()
    let myView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expenseTableView.delegate = self
        expenseTableView.dataSource = self
        incomeTableView.delegate = self
        incomeTableView.dataSource = self
        
        expenseTableView.register(UINib(nibName: "CheckPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "DLcell")
        incomeTableView.register(UINib(nibName: "CheckPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "DLcell")
        
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        collectionView.backgroundColor = Function.viewColor()
        collectionView.register(UINib(nibName: "CheckPaymentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cpCell")
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        collectionView.collectionViewLayout = cellLayout
        
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 60).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.addSubview(myView)
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        myView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        myView.backgroundColor = .white
        myView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 190 - self.navigationController!.navigationBar.frame.height - tabBarController!.tabBar.frame.height).isActive = true
//        myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2).isActive = true
        myView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 2).isActive = true
       
        expenseTableView.backgroundColor = .red
        myView.addSubview(expenseTableView)
        expenseTableView.translatesAutoresizingMaskIntoConstraints = false
        expenseTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        expenseTableView.topAnchor.constraint(equalTo: self.myView.topAnchor).isActive = true
        expenseTableView.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor).isActive = true
        
        incomeTableView.backgroundColor = .blue
        myView.addSubview(incomeTableView)
        incomeTableView.translatesAutoresizingMaskIntoConstraints = false
        incomeTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        incomeTableView.topAnchor.constraint(equalTo: self.myView.topAnchor).isActive = true
        incomeTableView.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor).isActive = true
        incomeTableView.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CPAccounts = Function.getAccounts()
        CPExpensePayments = CPAccounts[CPRowNumber].expensePayments
        CPIncomePayments = CPAccounts[CPRowNumber].incomePayments
        self.expenseTableView.reloadData()
        self.incomeTableView.reloadData()
        
        expenseTotalMoney = 0
        incomeTotalMoney = 0
        
        for payment in CPExpensePayments {
            guard let intMoney = Int(payment.money) else {
                return
            }
            expenseTotalMoney = expenseTotalMoney + intMoney
        }
        
        for payment in CPIncomePayments {
            guard let intMoney = Int(payment.money) else {
                return
            }
            incomeTotalMoney = incomeTotalMoney + intMoney
        }
    }

}

extension CheckPaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cpCell", for: indexPath) as! CheckPaymentCollectionViewCell
        cell.backgroundColor = Function.cellColor()
        cell.titleLabel.textColor = .white
        cell.moneyLabel.textColor = .white
        if indexPath.item == 0 {
            cell.titleLabel.text = "支出"
            cell.moneyLabel.text = String(expenseTotalMoney) + "円"
        } else if indexPath.item == 1 {
            cell.titleLabel.text = "収入"
            cell.moneyLabel.text = String(incomeTotalMoney) + "円"
        } else {
            cell.moneyLabel.text = String(incomeTotalMoney - expenseTotalMoney) + "円"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGFloat
        if indexPath.item == 2 {
            cellSize = self.view.frame.width - 20
        } else {
            cellSize = (self.view.frame.width - 30) / 2
        }
        return CGSize(width: cellSize, height: 40)
    }
}

extension CheckPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case expenseTableView:
            return CPExpensePayments.count
        case incomeTableView:
            return CPIncomePayments.count
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DLcell", for: indexPath) as! CheckPaymentTableViewCell
        switch tableView {
        case expenseTableView:
            cell.titleLabel.text = CPExpensePayments[indexPath.row].content
            cell.moneyLabel.text = CPExpensePayments[indexPath.row].money + "円"
        case incomeTableView:
            cell.titleLabel.text = CPIncomePayments[indexPath.row].content
            cell.moneyLabel.text = CPIncomePayments[indexPath.row].money + "円"
        default:
            fatalError()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
