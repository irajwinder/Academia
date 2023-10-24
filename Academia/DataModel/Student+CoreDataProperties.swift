//
//  Student+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/24/23.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var studentName: String?
    @NSManaged public var studentID: Int64
    @NSManaged public var department: String?
    @NSManaged public var courseEnrolled: String?
    @NSManaged public var phoneNumber: Int64

}

extension Student : Identifiable {

}
