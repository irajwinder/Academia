//
//  DataManager.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import CoreData
import UIKit

//Singleton Class
class DataManager: NSObject {
    static let sharedInstance: DataManager = {
        let instance = DataManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    // Save University data to CoreData
    func saveUniversity(universityName: String, phoneNumber: Int64, location: String, entity: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Getting the entity description for the given entity name from the managed context
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedContext)
        
        // Creating a new instance of NSManagedObject
        let newUniversity = NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        newUniversity.setValue(universityName, forKey: "universityName")
        newUniversity.setValue(phoneNumber, forKey: "phoneNumber")
        newUniversity.setValue(location, forKey: "address")
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("University data saved successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Save Department data to CoreData
    func saveDepartment(universityName: University, departmentName: String, entity: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Getting the entity description for the given entity name from the managed context
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedContext)
        
        // Creating a new instance of NSManagedObject
        let newDepartment = NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        newDepartment.setValue(universityName, forKey: "university")
        newDepartment.setValue(departmentName, forKey: "departmentName")
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Department data saved successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Save Professor data to CoreData
    func saveProfessor(departmentName: Department, professorName: String, phoneNumber: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a Professor Object
        let newProfessor = Professor(context: managedContext)
        
        // Set the values for various attributes of the Professor entity
        newProfessor.setValue(departmentName, forKey: "department")
        newProfessor.professorName = professorName
        newProfessor.phoneNumber = Int64(phoneNumber) ?? 0
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Professor data saved successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Save Course data to CoreData
    func saveCourse(departmentName: Department, courseName: String, courseCode: String, courseSemester: String, courseAdvisor: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a Course Object
        let newCourse = Course(context: managedContext)
        
        // Set the values for various attributes of the Course entity
        newCourse.setValue(departmentName, forKey: "department")
        newCourse.courseName = courseName
        newCourse.courseCode = Int64(courseCode) ?? 0
        newCourse.semester = courseSemester
        newCourse.courseAdvisor = courseAdvisor
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Course data saved successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Save Student data to CoreData
    func saveStudent(courseName: Course, studentID: String, studentName: String, studentMajor: String, studentGPA: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a Student Object
        let newStudent = Student(context: managedContext)
        
        // Set the values for various attributes of the Student entity
        newStudent.setValue(courseName, forKey: "course")
        newStudent.studentID = Int64(studentID) ?? 0
        newStudent.studentName = studentName
        newStudent.major = studentMajor
        newStudent.gpa = Double(studentGPA) ?? 0.0

        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Student data saved successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Update university Data
    func updateUniversity(university: University, editUniversityName: String, editUniversityNumber: String, editUniversityAddress: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        // Update the university data
        university.universityName = editUniversityName
        university.phoneNumber = Int64(editUniversityNumber) ?? 0
        university.address = editUniversityAddress

        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("University data updated successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Update department Data
    func updateDepartment(department: Department, editDepartmentName: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        // Update the user data
        department.departmentName = editDepartmentName

        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Department data updated successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Update Professor Data
    func updateProfessor(professor: Professor, editProfessorName: String, editProfessorNumber: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        // Update the Professor data
        professor.professorName = editProfessorName
        professor.phoneNumber = Int64(editProfessorNumber) ?? 0

        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Professor data updated successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Update Professor Data
    func updateCourse(course: Course, editCourseName: String, editCourseCode: String, editCourseSemester: String, editCourseAdvisor: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        // Update the Course data
        course.courseName = editCourseName
        course.courseCode = Int64(editCourseCode) ?? 0
        course.semester = editCourseSemester
        course.courseAdvisor = editCourseAdvisor

        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Course data updated successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Update Student Data
    func updateStudent(student: Student, editStudentID: String, editStudentName: String, editStudentMajor: String, editStudentGPA: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        // Update the Student data
        student.studentID = Int64(editStudentID) ?? 0
        student.studentName = editStudentName
        student.major = editStudentMajor
        student.gpa = Double(editStudentGPA) ?? 0.0

        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("Student data updated successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Fetch University from Core Data
    func fetchUniversity() -> [University] {
        // Get a reference to the AppDelegate by accessing the shared instance of UIApplication
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        // Access the managed object context from the AppDelegate's persistent container.
        let managedContext = appDelegate.persistentContainer.viewContext

        do {
            //fetch the University based on the fetch request
            return try managedContext.fetch(University.fetchRequest())
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    //Delete function for deleting entities
    func deleteEntity(_ entity: NSManagedObject) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(entity)
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("\(entity.entity.name ?? "Entity") deleted successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}

let datamanagerInstance = DataManager.sharedInstance
