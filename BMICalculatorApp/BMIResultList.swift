//
//  BMIResultList.swift
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

import Foundation
import CoreData

@objc (BMIResultList)

public class BMIResultList : NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var height: Float
    @NSManaged public var weight: Float
    @NSManaged public var bmi: Float
    @NSManaged public var date: Date
}
extension BMIResultList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BMIResultList> {
        return NSFetchRequest<BMIResultList>(entityName: "BMIResultList")
    }
}
extension BMIResultList : Identifiable {
}
