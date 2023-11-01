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
    func saveDepartment(universityName: String, departmentName: String, entity: String) {
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
        newDepartment.setValue(departmentName, forKey: "departmentName")
        
        // Fetch the University entity based on the given university name
        let fetchRequest = University.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "universityName == %@", universityName)
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let university = results.first {
                // Establish the relationship between the department and university
                newDepartment.setValue(university, forKey: "university")
            }
        } catch let error as NSError {
            print("Error fetching university: \(error), \(error.userInfo)")
        }
        
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
    func saveProfessor(departmentName: String, professorName: String, phoneNumber: String) {
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
        
        // Fetch the Department entity based on the given Department name
        let fetchRequest = Department.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "departmentName == %@", departmentName)
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let department = results.first {
                // Establish the relationship between the professor and department
                newProfessor.setValue(department, forKey: "department")
            }
        } catch let error as NSError {
            print("Error fetching Department: \(error), \(error.userInfo)")
        }
        
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
    func saveCourse(departmentName: String, courseName: String, courseCode: String, courseSemester: String) {
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
        
        // Fetch the Department entity based on the given Department name
        let fetchRequest = Department.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "departmentName == %@", departmentName)
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let department = results.first {
                // Establish the relationship between the course and department
                newCourse.setValue(department, forKey: "department")
            }
        } catch let error as NSError {
            print("Error fetching Course: \(error), \(error.userInfo)")
        }
        
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
    func saveStudent(courseName: String, studentID: String, studentName: String, studentMajor: String, studentGPA: String) {
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
        newStudent.gpa = Double(studentGPA) ?? 0.0
        
        // Fetch the Course entity based on the given Course name
        let fetchRequest = Course.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "courseName == %@", courseName)
        print(fetchRequest)
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let course = results.first {
                print(course)
                // Establish the relationship between the student and course
                newStudent.setValue(course, forKey: "course")
            }
        } catch let error as NSError {
            print("Error fetching Department: \(error), \(error.userInfo)")
        }

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
    func updateCourse(course: Course, editCourseName: String, editCourseCode: String, editCourseSemester: String) {
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
    
    // Fetch Department from Core Data
    func fetchDepartmentsFromUniversity(universityName: String) -> [Department] {
        // Fetches all the universities
        let universities = fetchUniversity()
        // Checks if there is a university with the given name
        if let university = universities.first(where: { $0.universityName == universityName }),
           // Checks if the university's departments are available
           let departments = university.department as? Set<Department> {
            return Array(departments) // Converts the set of departments to an array and returns it
        } else {
            return [] // Returns an empty array if the university or its departments are not found
        }
    }
    
    // Fetch Professor from Core Data
    func fetchProfessorsFromDepartment(departmentName: String) -> [Professor] {
        // Fetch all departments from the university
        let allDepartments = fetchUniversity().flatMap { $0.department?.allObjects as? [Department] ?? [] }
        // Check if the specified department exists in the fetched departments
        if let department = allDepartments.first(where: { $0.departmentName == departmentName }),
           // retrieve professors from the department
           let professors = department.professor as? Set<Professor> {
            return Array(professors) // Convert the set of professors to an array and return it
        } else {
            return []
        }
    }
    
    // Fetch Course from Core Data
    func fetchCoursesFromDepartment(departmentName: String) -> [Course] {
        // Fetch all departments from the university
        let allDepartments = fetchUniversity().flatMap { $0.department?.allObjects as? [Department] ?? [] }
        // Check if the specified department exists in the fetched departments
        if let department = allDepartments.first(where: { $0.departmentName == departmentName }),
           // retrieve courses from the department
           let courses = department.course as? Set<Course> {
            return Array(courses) // Convert the set of courses to an array and return it
        } else {
            return []
        }
    }
    
    // Fetch Students from Core Data
    func fetchStudentsFromCourse(courseName: String) -> [Student] {
        // Fetch all departments from the university
        let allDepartments = fetchUniversity().flatMap { $0.department?.allObjects as? [Department] ?? [] }
        
        // Find the specific course by its name
        if let course = allDepartments.flatMap({ $0.course?.allObjects as? [Course] ?? [] })
            .first(where: { $0.courseName == courseName }),  // Filter the courses to find the one with the matching course name
           let students = course.student as? Set<Student> {  // Extract students enrolled in the found course
            return Array(students)  // Convert the set of students to an array and return it
        } else {
            return []  // Return an empty array if the course is not found or if there are no students in the course
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
