//  FirstViewController.swift
/*
    App Name: BMICalculatorApp
    Version: 1.0
 
    Created on: 2022-12-15.
    Created by: Krishna Patel (301268911)
 
    Description:
    This is a BMI Calculator App that will be used to calculate BMI based on the height and weight entered by user.
    The reset button will reset all the fields' values.
    The calculate button will calculate the BMI and displays the score along with category.
    The track BMI history button will redirect to the second screen, that displays user info and previous BMI records of for the user.
    If we swipe from left to right, we can edit the record by entering new value of weight,that will automatically calculate the new BMI and update the record.
    If we swipe from right to left, we can delete the record.
*/

import UIKit
import CoreData

class FirstViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var bmiResultList = [BMIResultList]()
    
    //variable declaration for textfields,labels and switch
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
    var roundedBMI:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //toggle switch for measurement unit selection
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
    
    //reset button functionality
    @IBAction func ResetBtn(_ sender: UIButton) {
        nameText.text = ""
        ageText.text = ""
        genderText.text = ""
        heightText.text = ""
        weightText.text = ""
        bmiResultLbl.text = "0"
        bmiMessageLbl.text = "Normal..!!"
    }
    
    //BMI calculation button functionality
    @IBAction func CalculateBtn(_ sender: UIButton) {
        weight = Float(self.weightText.text!)
        height = Float(self.heightText.text!)

        //for imperial units (pounds & inches)
        if imperialSwitch.isOn
        {
            bmi = Float((weight!*703)/(height!*height!))
            roundedBMI = round(bmi!*100)/100.0
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
        //for standard units (kg & cm)
        else
        {
            bmi = Float((weight!*10000)/(height!*height!))
            roundedBMI = round(bmi!*100)/100.0
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
        addResult(weight: Float(weight!) , bmi: Float(roundedBMI))
    }

    //add BMI record into coredata
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

    //navigate to second screen
    @IBAction func TrackBMIHistoryBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
}
