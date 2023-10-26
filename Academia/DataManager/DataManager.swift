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
    
    // Fetch Department from Core Data
    func fetchDepartment() -> [Department] {
        // Get a reference to the AppDelegate by accessing the shared instance of UIApplication
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        // Access the managed object context from the AppDelegate's persistent container.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //fetch the Department based on the fetch request
            return try managedContext.fetch(Department.fetchRequest())
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
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
    
    // Fetch Professor from Core Data
    func fetchProfessor() -> [Professor] {
        // Get a reference to the AppDelegate by accessing the shared instance of UIApplication
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        // Access the managed object context from the AppDelegate's persistent container.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //fetch the Professor based on the fetch request
            return try managedContext.fetch(Professor.fetchRequest())
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
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
    
    // Fetch Course from Core Data
    func fetchCourse() -> [Course] {
        // Get a reference to the AppDelegate by accessing the shared instance of UIApplication
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        // Access the managed object context from the AppDelegate's persistent container.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //fetch the Course based on the fetch request
            return try managedContext.fetch(Course.fetchRequest())
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
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
    
    // Fetch Student from Core Data
    func fetchStudent() -> [Student] {
        // Get a reference to the AppDelegate by accessing the shared instance of UIApplication
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        // Access the managed object context from the AppDelegate's persistent container.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            //fetch the Student based on the fetch request
            return try managedContext.fetch(Student.fetchRequest())
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}

let datamanagerInstance = DataManager.sharedInstance
