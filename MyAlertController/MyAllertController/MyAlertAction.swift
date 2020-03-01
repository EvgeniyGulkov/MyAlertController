//
//  MyAlertAction.swift
//  MyNewWizard
//
//  Created by Admin on 29.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

enum MyActionType {
    case cancel
    case _default
}

class MyAlertAction<T> {
    var textColor: UIColor = UIColor.white
    var backgroundColor: UIColor = UIColor.clear
    var title: String
    var type: MyActionType
    var completion: (([T])->())?
    
    init(title: String, type:MyActionType, completion: (([T])->())?) {
        self.title = title
        self.type = type
        self.completion = completion
    }
}
