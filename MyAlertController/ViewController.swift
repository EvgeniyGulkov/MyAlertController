//
//  ViewController.swift
//  MyNewWizard
//
//  Created by Admin on 29.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1)

        let alertController = MyAlertController<String>(title: "Info", message: "Standart message, great info")
        alertController.numberOfLines = 2
        alertController.multipleSelection = true
        
        let okAction = MyAlertAction<String>(title: "OK", type: ._default, completion: {items in
            print(items)
        })
        okAction.textColor = buttonColor
        
        let cancelAction = MyAlertAction<String>(title: "CANCEL", type: .cancel, completion: nil)
        cancelAction.textColor = buttonColor
        
        let array = ["option 1", "option 2", "option 3", "option 4"]
        
        alertController.addOption(option: array.map {MyAlertOption(name: $0, item: $0)})
        
        alertController.addAction(action: [okAction, cancelAction])
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }

}

