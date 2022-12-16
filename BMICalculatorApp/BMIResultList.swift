//
//  BMIResultList.swift
//  BMICalculatorApp
//
//  Created by Kisu on 2022-12-15.
//

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
