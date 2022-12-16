//
//  BMIResultList.swift
//  BMICalculatorApp
//
//  Created by Kisu on 2022-12-15.
//

import Foundation
import CoreData

@objc (BMIResults)
public class BMIResults : NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var height: Float
    @NSManaged public var weight: Float
    @NSManaged public var bmi: Float
    @NSManaged public var date: String?
}
