//
//  DateListViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/25.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class DateListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var DLAccounts = [Account]()
    var DLRowNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        tableView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        tableView.separatorColor = .white
        tableView.register(UINib(nibName: "DateListTableViewCell", bundle: nil), forCellReuseIdentifier: "DLcell")
        //viewdidloadここまで
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //登録済みのAccountsの読み込み
        DLAccounts = Function.getAccounts()
        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DLAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DLcell", for: indexPath) as! DateListTableViewCell
        cell.startLabel.text = DLAccounts[indexPath.row].startDate
        cell.startLabel.textColor = .white
        cell.endLabel.text = DLAccounts[indexPath.row].endDate
        cell.endLabel.textColor = .white
        cell.moneyLabel.textColor = .white
        cell.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DLAccounts.remove(at: indexPath.row)
            Function.setAccounts(object: DLAccounts)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNumber = indexPath.row
        performSegue(withIdentifier: "toTabBarVC", sender: rowNumber)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabBarVC" {
            let nextVC = segue.destination as! TabBarViewController
            nextVC.TBRowNumber = sender as! Int
        }
    }
}
