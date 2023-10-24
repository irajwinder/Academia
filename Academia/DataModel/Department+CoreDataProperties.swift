//
//  Department+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/24/23.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var departmentName: String?
    @NSManaged public var headOfDepartment: String?
    @NSManaged public var listOfProfessors: String?

}

extension Department : Identifiable {

}
