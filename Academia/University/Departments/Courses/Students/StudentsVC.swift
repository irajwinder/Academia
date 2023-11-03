//
//  StudentsVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

protocol AddStudentDelegate: AnyObject {
    func didAddStudent()
}

class StudentsVC: UIViewController {
    
    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var studentMajor: UITextField!
    @IBOutlet weak var studentGPA: UITextField!
    
    weak var delegate: AddStudentDelegate?
    var selectedCourse: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Student"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "StudentsVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .save, target: self, action: #selector(saveStudent))
            }
        }
    }
    
    //Save the Student to Core Data
    @objc func saveStudent() {
        //Validate before saving
        guard let studentID = self.studentID.text, Validation.isValidNumber(Int(studentID)) else {
            Validation.showAlert(on: self, with: "Invalid ID", message: "Please enter a valid ID.")
            return
        }
        
        guard let studentName = self.studentName.text, Validation.isValidName(studentName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid Name.")
            return
        }
        
        guard let studentMajor = self.studentMajor.text, Validation.isValidName(studentMajor) else {
            Validation.showAlert(on: self, with: "Invalid Major", message: "Please enter a valid Major.")
            return
        }
        
        guard let studentGPA = self.studentGPA.text, Validation.isValidGPA(Double(studentGPA)) else {
            Validation.showAlert(on: self, with: "Invalid GPA", message: "Please enter a valid GPA.")
            return
        }
        
        //Save the data
        guard let selectedCourse = selectedCourse?.courseName else {
            print("Error: Could not fetch!")
            return
        }
        datamanagerInstance.saveStudent(
            courseName: selectedCourse,
            studentID: studentID,
            studentName: studentName,
            studentMajor: studentMajor,
            studentGPA: studentGPA
        )
        // Call delegate method
        delegate?.didAddStudent()
        navigationController?.popViewController(animated: true)
    }
}
