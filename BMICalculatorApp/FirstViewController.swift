//
//  ViewController.swift
//  BMICalculatorApp
//
//  Created by Kisu on 2022-12-15.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var bmiResultList = [BMIResultList]()
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var imperialSwitch: UISwitch!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var bmiResultLbl: UILabel!
    @IBOutlet weak var bmiMessageLbl: UILabel!
    
    var name:String = ""
    var age:String = ""
    var gender:String = ""
    var height:Float? = 0
    var weight:Float? = 0
    var bmi:Float? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func UnitSwitch(_ sender: UISwitch) {
        if imperialSwitch.isOn {
            heightText.placeholder = "Enter Your Height In inches"
            weightText.placeholder = "Enter Your Weight In pounds"
        }
        else {
            heightText.placeholder = "Enter Your Height In cm"
            weightText.placeholder = "Enter Your Weight In kg"
        }
    }
    
    @IBAction func ResetBtn(_ sender: UIButton) {
        nameText.text = ""
        ageText.text = ""
        genderText.text = ""
        heightText.text = ""
        weightText.text = ""
        bmiResultLbl.text = "0"
        bmiMessageLbl.text = "Normal..!!"
    }
    
    @IBAction func CalculateBtn(_ sender: UIButton) {
        weight = Float(self.weightText.text!)
        height = Float(self.heightText.text!)

        if imperialSwitch.isOn
        {
            bmi = Float((weight!*703)/(height!*height!))
            self.bmiResultLbl.text = String(format:"%.\(2)f", bmi!)

            if (bmi! < 16) {self.bmiMessageLbl.text = "Severe Thinness"}
            else if (bmi! >= 16 && bmi! < 17) {self.bmiMessageLbl.text = "Moderate Thinness"}
            else if (bmi! >= 17 && bmi! < 18.5) {self.bmiMessageLbl.text = "Mild Thinness"}
            else if (bmi! >= 18.5 && bmi! < 25) {self.bmiMessageLbl.text = "Normal"}
            else if (bmi! >= 25 && bmi! < 30) {self.bmiMessageLbl.text = "Overweight"}
            else if (bmi! >= 30 && bmi! < 35) {self.bmiMessageLbl.text = "Obese Class I"}
            else if (bmi! >= 35 && bmi! <= 40) {self.bmiMessageLbl.text = "Obese Class II"}
            else if (bmi! > 40) {self.bmiMessageLbl.text = "Obese Class III"}
        }
        else
        {
            bmi = Float((weight!*10000)/(height!*height!))
            self.bmiResultLbl.text = String(format:"%.\(2)f", bmi!)

            if (bmi! < 16) {self.bmiMessageLbl.text = "Severe Thinness"}
            else if (bmi! >= 16 && bmi! < 17) {self.bmiMessageLbl.text = "Moderate Thinness"}
            else if (bmi! >= 17 && bmi! < 18.5) {self.bmiMessageLbl.text = "Mild Thinness"}
            else if (bmi! >= 18.5 && bmi! < 25) {self.bmiMessageLbl.text = "Normal"}
            else if (bmi! >= 25 && bmi! < 30) {self.bmiMessageLbl.text = "Overweight"}
            else if (bmi! >= 30 && bmi! < 35) {self.bmiMessageLbl.text = "Obese Class I"}
            else if (bmi! >= 35 && bmi! <= 40) {self.bmiMessageLbl.text = "Obese Class II"}
            else if (bmi! > 40) {self.bmiMessageLbl.text = "Obese Class III"}
        }
        addResult(weight: Float(weight!) , bmi: Float(bmi!))
    }

    func addResult(weight :Float, bmi : Float)
    {
        let date = Date()
        
        let newResult = BMIResultList(context: context)
        
        newResult.name = nameText.text
        newResult.age = ageText.text
        newResult.gender = genderText.text
        newResult.height = height!
        newResult.weight = weight
        newResult.bmi = bmi
        newResult.date = date
        //print(newResult)
        do
        {
            try context.save()
        }
        catch{}
    }

    @IBAction func TrackBMIHistoryBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //vc.weight = weightText.text
        //vc.bmi = bmiResultLbl.text
        vc.name = nameText.text
        vc.age = ageText.text
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
}
