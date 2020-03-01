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

        let alertController = MyAlertController<String>(title: "Warning", message: "To access the Mezzo functions you need to add a Mezzo.")
        alertController.numberOfLines = 3
        //alertController.multipleSelection = true
        
        let addAction = MyAlertAction<String>(title: "ADD MEZZO", type: .default, completion: {items in
            print(items)
        })
        addAction.textColor = buttonColor
        
        let cancelAction = MyAlertAction<String>(title: "CANCEL", type: .cancel, completion: nil)
        cancelAction.textColor = buttonColor
        
        let array = ["option 1", "option 2", "option 3", "option 4"]
        
        alertController.addOption(option: array.map {MyAlertOption(name: $0, item: $0)})
        
        alertController.addAction(action: [cancelAction, addAction])
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }

}

