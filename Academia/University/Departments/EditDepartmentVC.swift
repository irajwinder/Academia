//
//  EditDepartmentVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/26/23.
//

import UIKit

protocol EditDepartmentDelegate: AnyObject {
    func didUpdateDepartment()
}

class EditDepartmentVC: UIViewController {
    
    @IBOutlet weak var editDepartmentName: UITextField!
    
    var department: Department?
    var isEditingEnabled = false
    weak var delegate: EditDepartmentDelegate?
    
    var selectedDepartmentName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Department Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditDepartmentVC" {
                if isEditingEnabled {
                    // If editing is enabled, show "Save" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                        title: "Save", style: .plain, target: self, action: #selector(saveButton))
                }else {
                    // If editing is not enabled, show "Edit" button
                    let editButton = UIBarButtonItem(
                        title: "Edit", style: .plain, target: self, action: #selector(editButton))
                    let departmentButton = UIBarButtonItem(
                        title: "Professor(s)", style: .plain, target: self, action: #selector(professor))
                    let courseButton = UIBarButtonItem(
                        title: "Course(s)", style: .plain, target: self, action: #selector(course))
                    self.navigationItem.rightBarButtonItems = [editButton, departmentButton, courseButton]
                }
            }
        }
        
        //Disable editing
        editDepartmentName.isEnabled = isEditingEnabled
        
        //Set the Department info
        if let department = department {
            editDepartmentName.text = department.departmentName
        }
    }
    
    @objc func editButton() {
        //Enable editing and change button to "Save"
        isEditingEnabled = true
        viewDidLoad() // Refresh the view to apply changes
    }
    
    @objc func saveButton() {
        //Validate before saving
        //Validate before saving
        guard let departmentName = self.editDepartmentName.text, Validation.isValidName(departmentName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        // Save changes and disable editing
        isEditingEnabled = false
                
        guard let department = department else {
            // Handle the case when the department object is nil
            print("Error: department object is nil.")
            return
        }
        datamanagerInstance.updateDepartment(
            department: department,
            editDepartmentName: departmentName
        )
        // Call delegate method
        delegate?.didUpdateDepartment()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func professor() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let departmentsListTableVC = storyboard.instantiateViewController(withIdentifier: "ProfessorsListTableVC") as? ProfessorsListTableVC {
            departmentsListTableVC.selectedDepartment = self.selectedDepartmentName
            navigationController?.pushViewController(departmentsListTableVC, animated: true)
        }
    }
    
    @objc func course() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let coursesListTableVC = storyboard.instantiateViewController(withIdentifier: "CoursesListTableVC") as? CoursesListTableVC {
            coursesListTableVC.selectedDepartment = self.selectedDepartmentName
            navigationController?.pushViewController(coursesListTableVC, animated: true)
        }
    }
    
}
