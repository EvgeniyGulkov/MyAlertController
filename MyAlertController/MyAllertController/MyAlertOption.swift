//
//  MyAlertOption.swift
//  MyNewWizard
//
//  Created by Admin on 29.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MyAlertOption<T> {
    var name: String
    var item: T
    var isSelected: Bool = false
    var textColor: UIColor = UIColor.white
    
    init(name: String, item: T) {
        self.name = name
        self.item = item
    }
}
