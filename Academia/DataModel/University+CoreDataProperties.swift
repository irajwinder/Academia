//
//  University+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/27/23.
//
//

import Foundation
import CoreData


extension University {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<University> {
        return NSFetchRequest<University>(entityName: "University")
    }

    @NSManaged public var address: String?
    @NSManaged public var phoneNumber: Int64
    @NSManaged public var universityName: String?
    @NSManaged public var department: NSSet?

}

// MARK: Generated accessors for department
extension University {

    @objc(addDepartmentObject:)
    @NSManaged public func addToDepartment(_ value: Department)

    @objc(removeDepartmentObject:)
    @NSManaged public func removeFromDepartment(_ value: Department)

    @objc(addDepartment:)
    @NSManaged public func addToDepartment(_ values: NSSet)

    @objc(removeDepartment:)
    @NSManaged public func removeFromDepartment(_ values: NSSet)

}

extension University : Identifiable {

}
