//
//  MyNewAlertView.swift
//  MyNewWizard
//
//  Created by Admin on 29.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MyAlertController<T>: UIViewController {
    private var alertView: MyAlert<T>!
    private var message: String!
    
    var numberOfLines: Int {
        get {
            return self.alertView.numberOfLines
        }
        set {
            self.alertView.numberOfLines = newValue
        }
    }
    
    var multipleSelection: Bool {
        get {
            return alertView.multipleSelection
        }
        set {
            alertView.multipleSelection = newValue
        }
    }
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.message = message
        self.alertView = MyAlert(frame: self.view.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func commonInit() {
        self.modalPresentationStyle = .overFullScreen
        self.alertView.baseBackgroundColor = UIColor.black
        self.alertView.title = self.title!
        self.alertView.message = self.message
        self.view.addSubview(self.alertView)
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.clear
    }

    func addAction(action: [MyAlertAction<T>]) {
        action.forEach { newAction in
        if newAction.type == .cancel {
            newAction.completion = self.close
        }
        self.alertView.addAction(action: newAction)
        }
    }
    
    func addOption(option: [MyAlertOption<T>]) {
        self.alertView.addOption(option: option)
    }
    
    private func close (_: [T]) -> () {
        self.dismiss(animated: true, completion: nil)
    }
    

}
