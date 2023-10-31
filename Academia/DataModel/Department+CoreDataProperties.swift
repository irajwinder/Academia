//
//  Department+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/31/23.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var departmentName: String?
    @NSManaged public var course: NSSet?
    @NSManaged public var professor: NSSet?
    @NSManaged public var university: University?

}

// MARK: Generated accessors for course
extension Department {

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
extension Department {

    @objc(addProfessorObject:)
    @NSManaged public func addToProfessor(_ value: Professor)

    @objc(removeProfessorObject:)
    @NSManaged public func removeFromProfessor(_ value: Professor)

    @objc(addProfessor:)
    @NSManaged public func addToProfessor(_ values: NSSet)

    @objc(removeProfessor:)
    @NSManaged public func removeFromProfessor(_ values: NSSet)

}

extension Department : Identifiable {

}
