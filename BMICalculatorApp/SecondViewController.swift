//
//  SecondViewController.swift
//  BMICalculatorApp
//
//  Created by Kisu on 2022-12-15.
//

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
        nameLbl.text = name
        ageLbl.text = age
        getAllRecords()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bmiResult = bmiResultList[indexPath.row]
        let cell = bmiTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        //dateFormatter.dateFormat = "EEEE, MMMM d,yyyy"
        cell.date.text = dateFormatter.string(from: bmiResult.date)
        cell.bmi.text = String(bmiResult.bmi)
        cell.weight.text = String(bmiResult.weight)
        
        return cell
    }
    
    // edit BMI record on left to right swipe
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
    
    @IBAction func AddNewRecordBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getAllRecords() {
        do {
            bmiResultList = try context.fetch(BMIResultList.fetchRequest())
            DispatchQueue.main.async {
                self.bmiTableView.reloadData()
            }
        }
        catch {}
    }
    
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
