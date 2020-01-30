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
//        myView.backgroundColor = .white
        myView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 190 - self.navigationController!.navigationBar.frame.height - tabBarController!.tabBar.frame.height).isActive = true
//        myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2).isActive = true
        myView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 2).isActive = true
       
        let expenseTitleLabel = UILabel()
        expenseTitleLabel.text = "支出"
        myView.addSubview(expenseTitleLabel)
        expenseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseTitleLabel.topAnchor.constraint(equalTo: myView.topAnchor).isActive = true
        expenseTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        expenseTableView.separatorStyle = .none
        myView.addSubview(expenseTableView)
        expenseTableView.translatesAutoresizingMaskIntoConstraints = false
        expenseTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20).isActive = true
        expenseTableView.topAnchor.constraint(equalTo: expenseTitleLabel.bottomAnchor, constant: 10).isActive = true
        expenseTableView.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor).isActive = true
        expenseTableView.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 10).isActive = true
        
        let incomeTitleLabel = UILabel()
        incomeTitleLabel.text = "収入"
        myView.addSubview(incomeTitleLabel)
        incomeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeTitleLabel.topAnchor.constraint(equalTo: myView.topAnchor).isActive = true
        incomeTitleLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        
        incomeTableView.separatorStyle = .none
        myView.addSubview(incomeTableView)
        incomeTableView.translatesAutoresizingMaskIntoConstraints = false
        incomeTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20).isActive = true
        incomeTableView.topAnchor.constraint(equalTo: incomeTitleLabel.bottomAnchor, constant: 10).isActive = true
        incomeTableView.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor).isActive = true
        incomeTableView.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -10).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CPAccounts = Function.getAccounts()
        CPExpensePayments = CPAccounts[CPRowNumber].expensePayments
        CPIncomePayments = CPAccounts[CPRowNumber].incomePayments
        expenseTableView.reloadData()
        incomeTableView.reloadData()
        
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
        collectionView.reloadData()
    }

}

extension CheckPaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cpCell", for: indexPath) as! CheckPaymentCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        cell.layer.cornerRadius = 5
        if indexPath.item == 0 {
            cell.titleLabel.text = "支出"
            cell.moneyLabel.text = "-" +  String(expenseTotalMoney) + "円"
            cell.moneyLabel.textColor = UIColor(red: 255/255, green: 80/255, blue: 0/255, alpha: 1)
        } else if indexPath.item == 1 {
            cell.titleLabel.text = "収入"
            cell.moneyLabel.text = "+" + String(incomeTotalMoney) + "円"
            cell.moneyLabel.textColor = UIColor(red: 0/255, green: 100/255, blue: 255/255, alpha: 1)
        } else {
            cell.titleLabel.text = "収支"
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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        cell.layer.cornerRadius = 5
        switch tableView {
        case expenseTableView:
            cell.contentLabel.text = CPExpensePayments[indexPath.row].content
            cell.moneyLabel.text = CPExpensePayments[indexPath.row].money + "円"
            cell.titleLabel.text = CPExpensePayments[indexPath.row].title
        case incomeTableView:
            cell.contentLabel.text = CPIncomePayments[indexPath.row].content
            cell.moneyLabel.text = CPIncomePayments[indexPath.row].money + "円"
            cell.titleLabel.text = CPIncomePayments[indexPath.row].title
        default:
            fatalError()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert: UIAlertController = UIAlertController(title: "確認", message: "削除していいですか?", preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        switch tableView {
        case expenseTableView:
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.CPExpensePayments.remove(at: indexPath.row)
                self.CPAccounts[self.CPRowNumber].expensePayments.remove(at: indexPath.row)
                Function.setAccounts(object: self.CPAccounts)
                self.viewWillAppear(true)
            }
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
            
        case incomeTableView:
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.CPIncomePayments.remove(at: indexPath.row)
                self.CPAccounts[self.CPRowNumber].incomePayments.remove(at: indexPath.row)
                Function.setAccounts(object: self.CPAccounts)
                self.viewWillAppear(true)
            }
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
            
        default:
            fatalError()
        }
    }
    
}
