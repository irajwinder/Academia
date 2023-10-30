//
//  Professor+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/27/23.
//
//

import Foundation
import CoreData


extension Professor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Professor> {
        return NSFetchRequest<Professor>(entityName: "Professor")
    }

    @NSManaged public var phoneNumber: Int64
    @NSManaged public var professorName: String?
    @NSManaged public var course: NSSet?
    @NSManaged public var department: Department?

}

// MARK: Generated accessors for course
extension Professor {

    @objc(addCourseObject:)
    @NSManaged public func addToCourse(_ value: Course)

    @objc(removeCourseObject:)
    @NSManaged public func removeFromCourse(_ value: Course)

    @objc(addCourse:)
    @NSManaged public func addToCourse(_ values: NSSet)

    @objc(removeCourse:)
    @NSManaged public func removeFromCourse(_ values: NSSet)

}

extension Professor : Identifiable {

}
