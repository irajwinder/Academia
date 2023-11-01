//
//  EditCourseVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/27/23.
//

import UIKit

protocol EditCourseDelegate: AnyObject {
    func didUpdateCourse()
}

class EditCourseVC: UIViewController {
    
    @IBOutlet weak var editCourseName: UITextField!
    @IBOutlet weak var editCourseCode: UITextField!
    @IBOutlet weak var editCourseSemester: UITextField!
    
    var course: Course?
    var isEditingEnabled = false
    weak var delegate: EditCourseDelegate?
    
    var selectedCourseName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Course Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditCourseVC" {
                if isEditingEnabled {
                    // If editing is enabled, show "Save" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton))
                } else {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(ellipsisButton))
                }
            }
        }

        //Disable editing
        editCourseName.isEnabled = isEditingEnabled
        editCourseCode.isEnabled = isEditingEnabled
        editCourseSemester.isEnabled = isEditingEnabled
        
        //Set the Course info
        if let course = course {
            editCourseName.text = course.courseName
            editCourseCode.text = String(course.courseCode)
            editCourseSemester.text = course.semester
        }
    }
    
    @objc func ellipsisButton(sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.editButton()
        })
        let studentAction = UIAlertAction(title: "Student(s)", style: .default, handler: { _ in
            self.student()
        })
        optionMenu.addAction(editAction)
        optionMenu.addAction(studentAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.barButtonItem = sender
            popoverController.permittedArrowDirections = .right
            popoverController.sourceView = self.view
        }
        present(optionMenu, animated: true, completion: nil)
    }
    
    @objc func editButton() {
        //Enable editing and change button to "Save"
        isEditingEnabled = true
        viewDidLoad() // Refresh the view to apply changes
    }
    
    @objc func saveButton() {
        //Validate before saving
        guard let editCourseName = self.editCourseName.text, Validation.isValidName(editCourseName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        guard let editCourseCode = self.editCourseCode.text, Validation.isValidNumber(Int(editCourseCode)) else {
            Validation.showAlert(on: self, with: "Invalid Code", message: "Please enter a valid Code.")
            return
        }
        
        guard let editCourseSemester = self.editCourseSemester.text, Validation.isValidName(editCourseSemester) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid Semester.")
            return
        }
        
        // Save changes and disable editing
        isEditingEnabled = false
                
        guard let course = course else {
            // Handle the case when the course object is nil
            print("Error: course object is nil.")
            return
        }
        datamanagerInstance.updateCourse(
            course: course,
            editCourseName: editCourseName,
            editCourseCode: editCourseCode,
            editCourseSemester: editCourseSemester
        )
        // Call delegate method
        delegate?.didUpdateCourse()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func student() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let studentsListTableVC = storyboard.instantiateViewController(withIdentifier: "StudentsListTableVC") as? StudentsListTableVC {
            studentsListTableVC.selectedCourse = self.selectedCourseName
            navigationController?.pushViewController(studentsListTableVC, animated: true)
        }
    }

}
