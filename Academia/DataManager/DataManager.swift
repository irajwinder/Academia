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
    func saveUniversity(universityName: String, phoneNumber: String, location: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        //Create a University Object
        let newUniversity = University(context: managedContext)

        // Set the values for various attributes of the University entity
        newUniversity.universityName = universityName
        newUniversity.phoneNumber = Int64(phoneNumber) ?? 0
        newUniversity.address = location
        
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
    func saveDepartment(departmentName: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext

        //Create a Department Object
        let newDepartment = Department(context: managedContext)

        // Set the values for various attributes of the Department entity
        newDepartment.departmentName = departmentName
        
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
    func saveProfessor(professorName: String, phoneNumber: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a Professor Object
        let newProfessor = Professor(context: managedContext)
        
        // Set the values for various attributes of the Professor entity
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
    func saveCourse(courseName: String, courseCode: String, courseSemester: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a Course Object
        let newCourse = Course(context: managedContext)
        
        // Set the values for various attributes of the Course entity
        newCourse.courseName = courseName
        newCourse.courseCode = Int64(courseCode) ?? 0
        newCourse.semester = courseSemester
        
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
    func saveStudent(studentID: String, studentName: String, studentMajor: String, studentGPA: String) {
        // Obtains a reference to the AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Accessing the managed context from the persistent container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a Student Object
        let newStudent = Student(context: managedContext)
        
        // Set the values for various attributes of the Student entity
        newStudent.studentID = Int64(studentID) ?? 0
        newStudent.studentName = studentName
        newStudent.major = studentMajor
        newStudent.gpa = studentGPA

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
    
    // Fetch data for University, Department, Professor, Course, Student from Core Data
    func fetchAllData() -> (universities: [University], departments: [Department], professors: [Professor], courses: [Course], students: [Student]) {
        // Get a reference to the AppDelegate by accessing the shared instance of UIApplication
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ([], [], [], [], [])
        }
        // Access the managed object context from the AppDelegate's persistent container.
        let managedContext = appDelegate.persistentContainer.viewContext

        do {
            // Fetch all the entities
            let universities = try managedContext.fetch(University.fetchRequest())
            let departments = try managedContext.fetch(Department.fetchRequest())
            let professors = try managedContext.fetch(Professor.fetchRequest())
            let courses = try managedContext.fetch(Course.fetchRequest())
            let students = try managedContext.fetch(Student.fetchRequest())

            return (universities, departments, professors, courses, students)
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return ([], [], [], [], [])
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
