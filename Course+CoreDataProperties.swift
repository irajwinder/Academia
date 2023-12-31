//
//  Course+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/31/23.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var courseCode: Int64
    @NSManaged public var courseName: String?
    @NSManaged public var semester: String?
    @NSManaged public var courseAdvisor: String?
    @NSManaged public var department: Department?
    @NSManaged public var professor: Professor?
    @NSManaged public var student: NSSet?

}

// MARK: Generated accessors for student
extension Course {

    @objc(addStudentObject:)
    @NSManaged public func addToStudent(_ value: Student)

    @objc(removeStudentObject:)
    @NSManaged public func removeFromStudent(_ value: Student)

    @objc(addStudent:)
    @NSManaged public func addToStudent(_ values: NSSet)

    @objc(removeStudent:)
    @NSManaged public func removeFromStudent(_ values: NSSet)

}

extension Course : Identifiable {

}
