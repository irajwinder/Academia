//
//  EditStudentVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/27/23.
//

import UIKit

protocol EditStudentDelegate: AnyObject {
    func didUpdateStudent()
}

class EditStudentVC: UIViewController {
    
    @IBOutlet weak var editStudentID: UITextField!
    @IBOutlet weak var editStudentName: UITextField!
    @IBOutlet weak var editStudentMajor: UITextField!
    @IBOutlet weak var editStudentGPA: UITextField!
    
    var selectedStudent: Student?
    var isEditingEnabled = false
    weak var delegate: EditStudentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Course Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditStudentVC" {
                if isEditingEnabled {
                    // If editing is enabled, show "Save" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                        title: "Save", style: .plain, target: self, action: #selector(saveButton))
                } else {
                    // If editing is not enabled, show "Edit" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                        title: "Edit", style: .plain, target: self, action: #selector(editButton))
                }
            }
        }

        //Disable editing
        editStudentID.isEnabled = isEditingEnabled
        editStudentName.isEnabled = isEditingEnabled
        editStudentMajor.isEnabled = isEditingEnabled
        editStudentGPA.isEnabled = isEditingEnabled
        
        //Set the student info
        if let student = selectedStudent {
            editStudentID.text = String(student.studentID)
            editStudentName.text = student.studentName
            editStudentMajor.text = student.major
            editStudentGPA.text = String(student.gpa)
        }
    }
    
    @objc func editButton() {
        //Enable editing and change button to "Save"
        isEditingEnabled = true
        viewDidLoad() // Refresh the view to apply changes
    }
    
    @objc func saveButton() {
        //Validate before saving
        guard let editStudentID = self.editStudentID.text, Validation.isValidName(editStudentID) else {
            Validation.showAlert(on: self, with: "Invalid ID", message: "Please enter a valid ID.")
            return
        }
        
        guard let editStudentName = self.editStudentName.text, Validation.isValidName(editStudentName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid Name.")
            return
        }
        
        guard let editStudentMajor = self.editStudentMajor.text, Validation.isValidName(editStudentMajor) else {
            Validation.showAlert(on: self, with: "Invalid Major", message: "Please enter a valid Major.")
            return
        }
        
        guard let editStudentGPA = self.editStudentGPA.text, Validation.isValidName(editStudentGPA) else {
            Validation.showAlert(on: self, with: "Invalid GPA", message: "Please enter a valid GPA.")
            return
        }
        
        // Save changes and disable editing
        isEditingEnabled = false
                
        guard let student = selectedStudent else {
            // Handle the case when the student object is nil
            print("Error: student object is nil.")
            return
        }
        datamanagerInstance.updateStudent(
            student: student,
            editStudentID: editStudentID,
            editStudentName: editStudentName,
            editStudentMajor: editStudentMajor,
            editStudentGPA: editStudentGPA
        )
        // Call delegate method
        delegate?.didUpdateStudent()
        navigationController?.popViewController(animated: true)
    }
   
}
