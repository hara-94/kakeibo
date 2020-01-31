//
//  ManagePaymentViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/26.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class ManagePaymentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    var MPAccounts = [Account]()
    var MPRowNumber: Int = 0
    var MPExpenseCategories = [String]()
    var MPIncomeCategories = [String]()
    var expensePickerView = UIPickerView()
    var incomePickerView = UIPickerView()
    let expenseTextField = UITextField()
    let incomeTextField = UITextField()
    let expenseCategoryTextField = UITextField()
    let incomeCategoryTextField = UITextField()
    let expenseTitleTextField = UITextField()
    let incomeTitleTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseTextField.delegate = self
        incomeTextField.delegate = self
        expenseCategoryTextField.delegate = self
        incomeCategoryTextField.delegate = self
        expenseTitleTextField.delegate = self
        incomeTitleTextField.delegate = self
        gestureRecognizer.delegate = self
        
        
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.cornerRadius = 20
        scrollView.layer.borderColor = Function.buttonColor().cgColor
        scrollView.layer.borderWidth = 2
        scrollView.keyboardDismissMode = .onDrag
        
        expensePickerView.delegate = self
        expensePickerView.dataSource = self
        
        
        incomePickerView.delegate = self
        incomePickerView.dataSource = self
        
        let expenseToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        let expenseDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(expenseDone))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        expenseToolBar.setItems([spaceItem, expenseDoneItem], animated: true)
        expenseCategoryTextField.inputView = expensePickerView
        expenseCategoryTextField.inputAccessoryView = expenseToolBar
        
        let incomeToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        let incomeDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(incomeDone))
        incomeToolBar.setItems([spaceItem, incomeDoneItem], animated: true)
        incomeCategoryTextField.inputView = incomePickerView
        incomeCategoryTextField.inputAccessoryView = incomeToolBar
        
        let expenseLabel = UILabel()
        expenseLabel.text = "支出"
        expenseLabel.textAlignment = .center
        contentView.addSubview(expenseLabel)
        expenseLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        expenseLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        expenseLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -160).isActive = true
        
        let incomeLabel = UILabel()
        incomeLabel.text = "収入"
        incomeLabel.textAlignment = .center
        incomeLabel.sizeToFit()
        contentView.addSubview(incomeLabel)
        incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        incomeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        incomeLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -160).isActive = true
        
//        expenseTextField.backgroundColor = .white
        expenseTextField.textAlignment = .right
        expenseTextField.borderStyle = .roundedRect
        expenseTextField.keyboardType = .numberPad
        contentView.addSubview(expenseTextField)
        expenseTextField.translatesAutoresizingMaskIntoConstraints = false
        expenseTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7).isActive = true
        expenseTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
                
        incomeTextField.textAlignment = .right
        incomeTextField.borderStyle = .roundedRect
        incomeTextField.keyboardType = .numberPad
        contentView.addSubview(incomeTextField)
        incomeTextField.translatesAutoresizingMaskIntoConstraints = false
        incomeTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7).isActive = true
        incomeTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        let expenseStackView = UIStackView()
        contentView.addSubview(expenseStackView)
        expenseStackView.addArrangedSubview(expenseTextField)
        expenseStackView.translatesAutoresizingMaskIntoConstraints = false
        expenseStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseStackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -80).isActive = true
        expenseStackView.spacing = 10
        expenseStackView.alignment = .bottom
        
        let incomeStackView = UIStackView()
        contentView.addSubview(incomeStackView)
        incomeStackView.addArrangedSubview(incomeTextField)
        incomeStackView.translatesAutoresizingMaskIntoConstraints = false
        incomeStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeStackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -80).isActive = true
        incomeStackView.spacing = 5
        incomeStackView.alignment = .bottom

        let expenseYenLabel = UILabel()
        expenseYenLabel.text = "円"
//        expenseYenLabel.textColor = .white
        expenseYenLabel.sizeToFit()
        let expenseYenLabelWidth = expenseYenLabel.frame.width
        expenseStackView.addArrangedSubview(expenseYenLabel)

        let incomeYenLabel = UILabel()
        incomeYenLabel.text = "円"
        incomeYenLabel.sizeToFit()
        let incomeYenLabelWidth = incomeYenLabel.frame.width
        incomeStackView.addArrangedSubview(incomeYenLabel)
        
        let expenseStackLabel = UILabel()
        expenseStackLabel.text = "金額"
        contentView.addSubview(expenseStackLabel)
        expenseStackLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseStackLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: expenseYenLabelWidth + 10).isActive = true
        expenseStackLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseStackLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -110).isActive = true
        
        let incomeStackLabel = UILabel()
        incomeStackLabel.text = "金額"
        contentView.addSubview(incomeStackLabel)
        incomeStackLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeStackLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        incomeStackLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeStackLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -110).isActive = true
        
        let expenseCategoryLabel = UILabel()
        expenseCategoryLabel.text = "カテゴリー"
        contentView.addSubview(expenseCategoryLabel)
        expenseCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseCategoryLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: expenseYenLabelWidth + 10).isActive = true
        expenseCategoryLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseCategoryLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -20).isActive = true
        
        let incomeCategoryLabel = UILabel()
        incomeCategoryLabel.text = "カテゴリー"
        contentView.addSubview(incomeCategoryLabel)
        incomeCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeCategoryLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        incomeCategoryLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeCategoryLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -20).isActive = true
        
        expenseCategoryTextField.borderStyle = .roundedRect
        contentView.addSubview(expenseCategoryTextField)
        expenseCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        expenseCategoryTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: expenseYenLabelWidth + 10).isActive = true
        expenseCategoryTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseCategoryTextField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 10).isActive = true
        
        incomeCategoryTextField.borderStyle = .roundedRect
        contentView.addSubview(incomeCategoryTextField)
        incomeCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        incomeCategoryTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        incomeCategoryTextField.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeCategoryTextField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 10).isActive = true
        
        
        let expenseTitleLabel = UILabel()
        expenseTitleLabel.text = "メモ"
        contentView.addSubview(expenseTitleLabel)
        expenseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseTitleLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        expenseTitleLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseTitleLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 70).isActive = true
        
        let incomeTitleLabel = UILabel()
        incomeTitleLabel.text = "メモ"
        contentView.addSubview(incomeTitleLabel)
        incomeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeTitleLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        incomeTitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeTitleLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 70).isActive = true
        
        expenseTitleTextField.borderStyle = .roundedRect
        expenseTitleTextField.returnKeyType = .done
        expenseTitleTextField.placeholder = "(任意)"
        contentView.addSubview(expenseTitleTextField)
        expenseTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        expenseTitleTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        expenseTitleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        expenseTitleTextField.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 100).isActive = true
        
        incomeTitleTextField.borderStyle = .roundedRect
        incomeTitleTextField.returnKeyType = .done
        incomeTitleTextField.placeholder = "(任意)"
        contentView.addSubview(incomeTitleTextField)
        incomeTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        incomeTitleTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.7, constant: 5 + incomeYenLabelWidth).isActive = true
        incomeTitleTextField.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeTitleTextField.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 100).isActive = true
        
        let expenseButton = UIButton()
        expenseButton.setTitle("支出を入力する", for: .normal)
        expenseButton.backgroundColor = Function.buttonColor()
        expenseButton.layer.cornerRadius = 12
        expenseButton.addTarget(self, action: #selector(expenseButtonOnPressed(_:)), for: .touchUpInside)
        contentView.addSubview(expenseButton)
        expenseButton.translatesAutoresizingMaskIntoConstraints = false
        expenseButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.6).isActive = true
        expenseButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        expenseButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 150).isActive = true
        
        let incomeButton = UIButton()
        incomeButton.setTitle("収入を入力する", for: .normal)
        incomeButton.backgroundColor = Function.buttonColor()
        incomeButton.layer.cornerRadius = 12
        incomeButton.addTarget(self, action: #selector(incomeButtonOnPressed(_:)), for: .touchUpInside)
        contentView.addSubview(incomeButton)
        incomeButton.translatesAutoresizingMaskIntoConstraints = false
        incomeButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.6).isActive = true
        incomeButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: self.view.frame.width / 2).isActive = true
        incomeButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 150).isActive = true
        //view did load ここまで
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MPAccounts = Function.getAccounts()
        MPExpenseCategories = MPAccounts[MPRowNumber].expenseCategory
        MPIncomeCategories = MPAccounts[MPRowNumber].incomeCategory
        
        if !MPExpenseCategories.isEmpty {
            expenseCategoryTextField.text = MPExpenseCategories[0]
            expenseCategoryTextField.isEnabled = true
        } else {
            expenseCategoryTextField.text = "カテゴリーが登録されていません"
            expenseCategoryTextField.isEnabled = false
        }
        
        if !MPIncomeCategories.isEmpty {
            incomeCategoryTextField.text = MPIncomeCategories[0]
            incomeCategoryTextField.isEnabled = true
        } else {
            incomeCategoryTextField.text = "カテゴリーが登録されていません"
            incomeCategoryTextField.isEnabled = false
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case expensePickerView:
            return MPExpenseCategories.count
        case incomePickerView:
            return MPIncomeCategories.count
        default:
            fatalError()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case expensePickerView:
            return MPExpenseCategories[row]
        case incomePickerView:
            return MPIncomeCategories[row]
        default:
            fatalError()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case expensePickerView:
            self.expenseCategoryTextField.text = MPExpenseCategories[row]
        case incomePickerView:
            self.incomeCategoryTextField.text = MPIncomeCategories[row]
        default:
            fatalError()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        expenseTitleTextField.resignFirstResponder()
        incomeTitleTextField.resignFirstResponder()
        return true
    }
    
    @objc func expenseDone() {
        expenseCategoryTextField.endEditing(true)
    }
    
    @objc func incomeDone() {
        incomeCategoryTextField.endEditing(true)
    }
    
    @objc func expenseButtonOnPressed(_ sender: Any) {
        if let expenseText = expenseTextField.text {
            if let expenseCategory = expenseCategoryTextField.text {
                if expenseText != "" {
                    if expenseCategory != "" {
                        if MPExpenseCategories.contains(expenseCategory) {
                            if Int(expenseText) != nil {
                                let title = expenseTitleTextField.text
                                let payment = Payment(content: expenseCategory, money: expenseText, title: title!)
                                MPAccounts[MPRowNumber].expensePayments.append(payment)
                                Function.setAccounts(object: MPAccounts)
                                expenseTextField.text = ""
                                expenseCategoryTextField.text = ""
                                expenseTitleTextField.text = ""
                                expenseTextField.endEditing(true)
                                expenseCategoryTextField.endEditing(true)
                            } else {
                                //有効な数字ではない場合
                                let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "有効な数字を入力してください", preferredStyle: .alert)
                                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(OKAction)
                                present(alert, animated: true) {
                                    self.expenseTextField.text = ""
                                }
                            }
                        } else {
                            //登録していないカテゴリーの場合
                            let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "登録されていないカテゴリーです", preferredStyle: .alert)
                            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(OKAction)
                            present(alert, animated: true) {
                                self.expenseCategoryTextField.text = ""
                            }
                        }
                    } else {
                        //epensecategoryが空の場合
                        let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "カテゴリーを入力してください", preferredStyle: .alert)
                        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        present(alert, animated: true, completion: nil)
                    }
                } else {
                    //expensetextが空の場合
                    let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "金額を入力してください", preferredStyle: .alert)
                    let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @objc func incomeButtonOnPressed(_ sender: Any) {
        if let incomeText = incomeTextField.text {
            if let incomeCategory = incomeCategoryTextField.text {
                if incomeText != "" {
                    if incomeCategory != "" {
                        if MPIncomeCategories.contains(incomeCategory) {
                            if Int(incomeText) != nil {
                                let title = incomeTitleTextField.text
                                let payment = Payment(content: incomeCategory, money: incomeText, title: title!)
                                MPAccounts[MPRowNumber].incomePayments.append(payment)
                                Function.setAccounts(object: MPAccounts)
                                incomeTextField.text = ""
                                incomeCategoryTextField.text = ""
                                incomeTitleTextField.text = ""
                                incomeTextField.endEditing(true)
                                incomeCategoryTextField.endEditing(true)
                            } else {
                                //有効な数字ではない場合
                                let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "有効な数字を入力してください", preferredStyle: .alert)
                                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(OKAction)
                                present(alert, animated: true) {
                                    self.incomeTextField.text = ""
                                }
                            }
                        } else {
                            //登録していないカテゴリーの場合
                            let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "登録されていないカテゴリーです", preferredStyle: .alert)
                            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(OKAction)
                            present(alert, animated: true) {
                                self.incomeCategoryTextField.text = ""
                            }
                        }
                    } else {
                        //epensecategoryが空の場合
                        let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "カテゴリーを入力してください", preferredStyle: .alert)
                        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        present(alert, animated: true, completion: nil)
                    }
                } else {
                    //expensetextが空の場合
                    let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "金額を入力してください", preferredStyle: .alert)
                    let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        self.expenseTextField.endEditing(true)
        self.expenseCategoryTextField.endEditing(true)
        self.expenseTitleTextField.endEditing(true)
        self.incomeTextField.endEditing(true)
        self.incomeCategoryTextField.endEditing(true)
        self.incomeTitleTextField.endEditing(true)
    }
    
}

extension ManagePaymentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
