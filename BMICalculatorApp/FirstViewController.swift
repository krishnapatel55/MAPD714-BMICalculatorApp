//
//  ViewController.swift
//  BMICalculatorApp
//
//  Created by Kisu on 2022-12-15.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var imperialSwitch: UISwitch!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var bmiResult: UILabel!
    @IBOutlet weak var bmiMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func UnitSwitch(_ sender: UISwitch) {
        if imperialSwitch.isOn {
            height.placeholder = "Enter Your Height In inches"
            weight.placeholder = "Enter Your Weight In pounds"
        }
        else {
            height.placeholder = "Enter Your Height In cm"
            weight.placeholder = "Enter Your Weight In kg"
        }
    }
    
    
    @IBAction func ResetBtn(_ sender: UIButton) {
        name.text = ""
        age.text = ""
        gender.text = ""
        height.text = ""
        weight.text = ""
        bmiResult.text = "0"
        bmiMessage.text = "Normal..!!"
    }
    
}

