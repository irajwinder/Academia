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

class EditCourseVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    @IBOutlet weak var editCourseName: UITextField!
    @IBOutlet weak var editCourseCode: UITextField!
    @IBOutlet weak var editCourseSemester: UITextField!
    @IBOutlet weak var editCourseAdvisor: UITextField!
    @IBOutlet weak var editCourseAdvisorPicker: UIPickerView!
    
    var course: Course?
    var isEditingEnabled = false
    weak var delegate: EditCourseDelegate?
    
    var selectedDepartment: String?
    var selectedCourseName: String?
    var professorNames: [Professor] = [] // hold the professor names

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
        editCourseAdvisor.isEnabled = isEditingEnabled
        editCourseAdvisorPicker.isHidden = true
        
        //Set the Course info
        if let course = course {
            editCourseName.text = course.courseName
            editCourseCode.text = String(course.courseCode)
            editCourseSemester.text = course.semester
            editCourseAdvisor.text = course.courseAdvisor
        }
        
        // Fetch professors for the selected department
        let fetch = datamanagerInstance.fetchProfessorsFromDepartment(departmentName: selectedDepartment!)
        self.professorNames = fetch
        
        // Set the data source and delegate for the UIPickerView.
        editCourseAdvisorPicker.dataSource = self
        editCourseAdvisorPicker.delegate = self
        
        // Set the delegate for the courseAdvisor text field
        editCourseAdvisor.delegate = self
    }
    
    // Show the picker when the courseAdvisor text field is clicked
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == editCourseAdvisor {
            editCourseAdvisorPicker.isHidden = false
            editCourseAdvisor.resignFirstResponder() // Dismiss the keyboard
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
        editCourseAdvisorPicker.isHidden = false
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
        
        guard let editCourseAdvisor = self.editCourseAdvisor.text, Validation.isValidName(editCourseAdvisor) else {
            Validation.showAlert(on: self, with: "Invalid Advisor", message: "Please select a valid Advisor.")
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
            editCourseSemester: editCourseSemester,
            editCourseAdvisor: editCourseAdvisor
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return professorNames.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return professorNames[row].professorName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Set the selected value from the picker to the editCourseAdvisor text field
        editCourseAdvisor.text = professorNames[row].professorName
        editCourseAdvisorPicker.isHidden = true
       }

}
