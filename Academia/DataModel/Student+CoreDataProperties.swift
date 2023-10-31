//
//  Student+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/31/23.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var gpa: Double
    @NSManaged public var major: String?
    @NSManaged public var studentID: Int64
    @NSManaged public var studentName: String?
    @NSManaged public var course: Course?

}

extension Student : Identifiable {

}
