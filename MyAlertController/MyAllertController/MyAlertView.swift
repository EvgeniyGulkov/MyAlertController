//
//  MyAlert.swift
//  MyNewWizard
//
//  Created by Admin on 29.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MyAlert<T>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var buttonStackView: UIStackView!
    @IBOutlet weak private var alertTitle: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var tableViewHeight: NSLayoutConstraint!
    
    var options: [MyAlertOption<T>] = []
    var actions: [MyAlertAction<T>] = []
    
    var multipleSelection: Bool = false
    
    var titleFont: UIFont {
        get {
            return self.alertTitle.font
        }
        set {
            self.alertTitle.font = newValue
        }
    }
    
    var messageFont: UIFont {
        get {
            return self.messageLabel.font
        }
        set {
            self.messageLabel.font = newValue
        }
    }
    
    var baseBackgroundColor: UIColor {
        get {
            return contentView.backgroundColor!
        }
        set {
            self.contentView.backgroundColor = newValue
        }
    }
    
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.contentView.layer.borderColor!)
        }
        set {
            self.contentView.layer.borderColor = newValue.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return self.contentView.layer.borderWidth
        }
        set {
            self.contentView.layer.borderWidth = newValue
        }
    }
    
    var title: String {
        get {
            return self.alertTitle.text!
        }
        set {
            self.alertTitle.text = newValue
        }
    }
    
    var message: String {
        get {
            return self.messageLabel.text!
        }
        set {
            self.messageLabel.text = newValue
        }
    }
    
    var numberOfLines: Int {
        get {
            return self.messageLabel.numberOfLines
        }
        set {
            self.messageLabel.numberOfLines = newValue
            if newValue == 0 {
                self.messageLabel.lineBreakMode = .byWordWrapping
            } else {
                self.messageLabel.lineBreakMode = .byTruncatingTail
            }
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: - Add Methods
    
    func addAction(action: MyAlertAction<T>) {
        let button = UIButton()
        button.addTarget(self, action: #selector(selector), for: .touchUpInside)
        button.setTitleColor(action.textColor, for: .normal)
        button.backgroundColor = action.backgroundColor
        button.setTitle(action.title, for: .normal)
        let font = self.messageLabel.font
        button.titleLabel?.font = font?.withSize(17)
        button.tag = self.actions.count
        actions.append(action)
        self.buttonStackView.addArrangedSubview(button)
    }
    
    func addOption(option: [MyAlertOption<T>]) {
        self.options.append(contentsOf: option)
        if !multipleSelection {
            self.options[0].isSelected = true
        }
        self.resizeTableView()
    }
    
    //MARK: - Private
    
    private func commonInit() {
        self.confureContentView()
        self.configureMessageLabel()
        self.configureTitleLabel()
        self.configureTableView()
    }
    
    private func confureContentView() {
        Bundle.main.loadNibNamed("MyAlert", owner: self, options: nil)
        addSubview(contentView)
        let delim: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.6 : 0.8
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.centerYAnchor.constraint(greaterThanOrEqualTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(greaterThanOrEqualTo: self.centerXAnchor).isActive = true
        widthConstraint.constant = self.bounds.width * delim
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 2.0
    }
    
    private func configureTableView() {
        self.tableViewHeight.constant = 0
        tableView.register(UINib(nibName: "MyAlertTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAlertTableViewCell")
    }
    
    private func configureMessageLabel() {
        self.messageLabel.textColor = UIColor.white
        self.messageLabel.numberOfLines = 0
        self.messageLabel.adjustsFontSizeToFitWidth = true
        self.messageLabel.minimumScaleFactor = 0.5
        self.messageLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func configureTitleLabel() {
        self.alertTitle.textColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @objc
    private func selector(_ sender: UIButton) {
        if let completion = self.actions[sender.tag].completion {
            let selectedOptions = options.filter {$0.isSelected}
            if !selectedOptions.isEmpty || !multipleSelection {
                completion(selectedOptions.map{$0.item})
            }
        }
    }
    
    private func resizeTableView() {
        if options.count > 3 {
            self.tableView.isScrollEnabled = true
            self.tableViewHeight.constant = self.tableView.rowHeight * 3
        } else {
            self.tableView.isScrollEnabled = false
            self.tableViewHeight.constant = self.tableView.rowHeight * CGFloat(options.count)
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAlertTableViewCell", for: indexPath) as! MyOptionTableViewCell
        let option = options[indexPath.row]
        
        cell.infoLabel.text = option.name
        cell.radioButton.isSelected = option.isSelected
        cell.infoLabel.textColor = option.textColor
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        
        if !multipleSelection {
            selectedOption.isSelected = true
            let _ = options.filter {$0 !== selectedOption}.map{$0.isSelected = false}
        } else {
            selectedOption.isSelected = !selectedOption.isSelected
        }
        tableView.reloadData()
    }
}
