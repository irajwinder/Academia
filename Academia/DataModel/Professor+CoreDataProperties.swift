//
//  Professor+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/24/23.
//
//

import Foundation
import CoreData


extension Professor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Professor> {
        return NSFetchRequest<Professor>(entityName: "Professor")
    }

    @NSManaged public var professorName: String?
    @NSManaged public var courseTaught: String?
    @NSManaged public var phoneNumber: Int64

}

extension Professor : Identifiable {

}
