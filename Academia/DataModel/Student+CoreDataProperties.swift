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

    @NSManaged public var gpa: String?
    @NSManaged public var major: String?
    @NSManaged public var studentID: Int64
    @NSManaged public var studentName: String?
    @NSManaged public var course: NSSet?
    @NSManaged public var professor: NSSet?

}

// MARK: Generated accessors for course
extension Student {

    @objc(addCourseObject:)
    @NSManaged public func addToCourse(_ value: Course)

    @objc(removeCourseObject:)
    @NSManaged public func removeFromCourse(_ value: Course)

    @objc(addCourse:)
    @NSManaged public func addToCourse(_ values: NSSet)

    @objc(removeCourse:)
    @NSManaged public func removeFromCourse(_ values: NSSet)

}

// MARK: Generated accessors for professor
extension Student {

    @objc(addProfessorObject:)
    @NSManaged public func addToProfessor(_ value: Professor)

    @objc(removeProfessorObject:)
    @NSManaged public func removeFromProfessor(_ value: Professor)

    @objc(addProfessor:)
    @NSManaged public func addToProfessor(_ values: NSSet)

    @objc(removeProfessor:)
    @NSManaged public func removeFromProfessor(_ values: NSSet)

}

extension Student : Identifiable {

}
