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
    
    var selectedDepartment: Department?
    var isEditingEnabled = false
    weak var delegate: EditDepartmentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Department Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditDepartmentVC" {
                if isEditingEnabled {
                    // If editing is enabled, show "Save" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton))
                } else {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(ellipsisButton))
                }
            }
        }
        
        //Disable editing
        editDepartmentName.isEnabled = isEditingEnabled
        
        //Set the Department info
        if let department = selectedDepartment {
            editDepartmentName.text = department.departmentName
        }
    }
    
    @objc func ellipsisButton(sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.editButton()
        })
        let professorAction = UIAlertAction(title: "Professor(s)", style: .default, handler: { _ in
            self.professor()
        })
        let courseAction = UIAlertAction(title: "Course(s)", style: .default, handler: { _ in
            self.course()
        })
        optionMenu.addAction(editAction)
        optionMenu.addAction(professorAction)
        optionMenu.addAction(courseAction)
        
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
        //Validate before saving
        guard let departmentName = self.editDepartmentName.text, Validation.isValidName(departmentName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        // Save changes and disable editing
        isEditingEnabled = false
                
        guard let department = selectedDepartment else {
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
            departmentsListTableVC.selectedDepartment = self.selectedDepartment
            navigationController?.pushViewController(departmentsListTableVC, animated: true)
        }
    }
    
    @objc func course() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let coursesListTableVC = storyboard.instantiateViewController(withIdentifier: "CoursesListTableVC") as? CoursesListTableVC {
            coursesListTableVC.selectedDepartment = self.selectedDepartment
            navigationController?.pushViewController(coursesListTableVC, animated: true)
        }
    }
    
}
