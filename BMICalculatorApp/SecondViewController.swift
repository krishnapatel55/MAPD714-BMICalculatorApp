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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    { // update task on left to right swipe
       let edit = UIContextualAction(style: .normal, title: "Edit"){(action,view,nil) in
           let subMenuVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
           let todo = self.models[indexPath.row]
           subMenuVC?.itemData = todo
           self.navigationController?.pushViewController(subMenuVC!, animated: true)
           print("edit")}
       edit.backgroundColor=UIColor.init(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
       return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let record = bmiRecords[indexPath.row]
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _,_,_ in
            let alert = UIAlertController(title: "Edit", message: "Edit BMI Record", preferredStyle : .alert)
            alert.addTextField(configurationHandler:  nil)
            alert.textFields?.first?.text = String(record.weight)
            let strWeight: String = String(record.weight)
            let thisWeight : Float? = Float(strWeight)
            let newBmi = record.bmi / Float(thisWeight!)
            alert.addAction(UIAlertAction(title: "Save",
                                          style: .default,
                                          handler:
                                          { [weak self] _ in guard
                                             let field = alert.textFields?.first,
                                             let newName = field.text,
                                             !newName.isEmpty
                else{
                    return
                    }
                let weight : Float? = Float(newName)
                self?.updateRecord(record: record, newWeight: Float(weight!), newBmi: newBmi*Float(weight!))
            }))
            self.present (alert,animated : true)
        }
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
    
}
