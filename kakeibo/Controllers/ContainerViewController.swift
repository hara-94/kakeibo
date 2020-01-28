//
//  ContainerViewController.swift
//  kakeibo
//
//  Created by 原ひかる on 2020/01/25.
//  Copyright © 2020 原ひかる. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //viewdidloadここまで
    }
    
    
    @IBAction func addButtonOnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAddDateVC", sender: nil)
    }
}
