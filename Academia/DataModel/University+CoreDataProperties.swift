//
//  University+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/24/23.
//
//

import Foundation
import CoreData


extension University {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<University> {
        return NSFetchRequest<University>(entityName: "University")
    }

    @NSManaged public var universityName: String?
    @NSManaged public var phoneNumber: Int64
    @NSManaged public var address: String?

}

extension University : Identifiable {

}
