//
//  SecondViewController.swift
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

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bmiResultList = [BMIResultList]()
    
    var name:String?
    var age:String?
    var date:String?
    var weight:String?
    var bmi:String?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var bmiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiTableView.dataSource = self
        bmiTableView.delegate = self
        getAllRecords()
    }
    
    //set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //display number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiResultList.count
    }
    
    //set cell values according to list data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bmiResult = bmiResultList[indexPath.row]
        nameLbl.text = bmiResult.name
        ageLbl.text = bmiResult.age
        let cell = bmiTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "MMMM d,yyyy      HH:mm"
        cell.date.text = dateFormatter.string(from: bmiResult.date)
        cell.bmi.text = String(bmiResult.bmi)
        cell.weight.text = String(bmiResult.weight)
        
        return cell
    }
    
    // edit BMI record on left to right swipe gesture functionality
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let bmiRecord = bmiResultList[indexPath.row]
        let edit = UIContextualAction(style: .normal, title: "Edit"){(action,view,nil) in
            // create the actual alert controller view that will be the pop-up
            let alertController = UIAlertController(title: "Edit BMI Record", message: "Enter new value for weight", preferredStyle: .alert)
            
            alertController.addTextField { (weight) in
                // configure the properties of the text field
                alertController.textFields?.first?.text = String(bmiRecord.weight)
            }
            
            // add the buttons/actions to the view controller
            let oldWeight : Float? = Float(bmiRecord.weight)
            let newBmi = bmiRecord.bmi / Float(oldWeight!)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                
                // this code runs when the user hits the "save" button
                let newWeight = alertController.textFields![0].text
                self.updateBMIRecord(record: bmiRecord, newWeight: Float(newWeight!)!, newBmi: newBmi*Float(newWeight!)!)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
        }
        edit.backgroundColor=UIColor.init(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    //delete BMI record on right to left swipe gesture functionality
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete"){ _, _, _ in
            self.context.delete(self.bmiResultList[indexPath.row])
            do
            {
                try self.context.save()
                self.getAllRecords()
            }
            catch{}
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //redirect to first screen to add new BMI record
    @IBAction func AddNewRecordBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //reload BMI records list
    func getAllRecords() {
        do {
            bmiResultList = try context.fetch(BMIResultList.fetchRequest())
            DispatchQueue.main.async {
                self.bmiTableView.reloadData()
            }
        }
        catch {}
    }
    
    //update BMI record
    func updateBMIRecord(record :BMIResultList, newWeight : Float, newBmi : Float){
        record.weight = Float(newWeight)
        let bmi = String(format: "%.2f", Float(newBmi))
        record.bmi = Float(bmi)!
        do{
            try context.save()
            getAllRecords()
        }
        catch{}
    }
    
}
