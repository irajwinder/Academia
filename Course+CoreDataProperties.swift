//
//  Course+CoreDataProperties.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/24/23.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var courseName: String?
    @NSManaged public var professorName: String?
    @NSManaged public var departmentName: String?
    @NSManaged public var enrolledStudents: String?

}

extension Course : Identifiable {

}
