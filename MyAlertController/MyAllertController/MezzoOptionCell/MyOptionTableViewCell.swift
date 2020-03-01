//
//  MyOptionTableViewCell.swift
//  MyNewWizard
//
//  Created by Admin on 29.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MyOptionTableViewCell: UITableViewCell {
        
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.textColor = UIColor.white
    }
}
