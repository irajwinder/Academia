//
//  EditUniversityVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/26/23.
//

import UIKit

protocol EditUniversityDelegate: AnyObject {
    func didUpdateUniversity()
}

class EditUniversityVC: UIViewController {
    
    @IBOutlet weak var editUniversityName: UITextField!
    @IBOutlet weak var editUniversityNumber: UITextField!
    @IBOutlet weak var editUniversityAddress: UITextField!
    
    var isEditingEnabled = false
    weak var delegate: EditUniversityDelegate?
    var selectedUniversityInstance: University? // Store the selected university
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "University Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditUniversityVC" {
                if isEditingEnabled {
                    // If editing is enabled, show "Save" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton))
                } else {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(ellipsisButton))
                }
            }
        }
        
        //Disable editing
        editUniversityName.isEnabled = isEditingEnabled
        editUniversityNumber.isEnabled = isEditingEnabled
        editUniversityAddress.isEnabled = isEditingEnabled
        
        //Set the University info
        if let university = selectedUniversityInstance {
            editUniversityName.text = university.universityName
            editUniversityNumber.text = String(university.phoneNumber)
            editUniversityAddress.text = university.address
        }
        
    }
    
    @objc func ellipsisButton(sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.editButton()
        })
        let departmentAction = UIAlertAction(title: "Department(s)", style: .default, handler: { _ in
            self.department()
        })
        optionMenu.addAction(editAction)
        optionMenu.addAction(departmentAction)
        
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
        guard let universityName = self.editUniversityName.text, Validation.isValidName(universityName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        guard let universityPhoneNumber = self.editUniversityNumber.text, Validation.isValidPhoneNumber(universityPhoneNumber) else {
            Validation.showAlert(on: self, with: "Invalid Number", message: "Please enter a valid phone Number.")
            return
        }
        
        guard let universityAddress = self.editUniversityAddress.text, Validation.isValidName(universityAddress) else {
            Validation.showAlert(on: self, with: "Invalid Address", message: "Please enter a valid Address.")
            return
        }
        
        // Save changes and disable editing
        isEditingEnabled = false
                
        guard let university = selectedUniversityInstance else {
            // Handle the case when the university object is nil
            print("Error: university object is nil.")
            return
        }
        datamanagerInstance.updateUniversity(
            university: university,
            editUniversityName: universityName,
            editUniversityNumber: universityPhoneNumber,
            editUniversityAddress: universityAddress
        )
        // Call delegate method
        delegate?.didUpdateUniversity()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func department() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let departmentsListTableVC = storyboard.instantiateViewController(withIdentifier: "DepartmentsListTableVC") as? DepartmentsListTableVC {
            departmentsListTableVC.selectedUniversityInstance = self.selectedUniversityInstance
            navigationController?.pushViewController(departmentsListTableVC, animated: true)
        }
    }
}
