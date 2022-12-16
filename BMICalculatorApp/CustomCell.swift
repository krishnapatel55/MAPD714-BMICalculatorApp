//
//  CustomCell.swift
//  BMICalculatorApp
//
//  Created by Kisu on 2022-12-15.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bmi: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
