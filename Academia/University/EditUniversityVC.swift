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
    
    var university: University?
    var isEditingEnabled = false
    weak var delegate: EditUniversityDelegate?
    
    var selectedUniversityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "University Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditUniversityVC" {
                if isEditingEnabled {
                    // If editing is enabled, show "Save" button
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                        title: "Save", style: .plain, target: self, action: #selector(saveButton))
                }else {
                    // If editing is not enabled, show "Edit" button
                    let editButton = UIBarButtonItem(
                        title: "Edit", style: .plain, target: self, action: #selector(editButton))
                    let departmentButton = UIBarButtonItem(
                        title: "Department(s)", style: .plain, target: self, action: #selector(department))
                    self.navigationItem.rightBarButtonItems = [editButton, departmentButton]
                }
            }
        }
        
        //Disable editing
        editUniversityName.isEnabled = isEditingEnabled
        editUniversityNumber.isEnabled = isEditingEnabled
        editUniversityAddress.isEnabled = isEditingEnabled
        
        //Set the University info
        if let university = university {
            editUniversityName.text = university.universityName
            editUniversityNumber.text = String(university.phoneNumber)
            editUniversityAddress.text = university.address
        }
        
        print(selectedUniversityName!)
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
                
        guard let university = university else {
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
            departmentsListTableVC.selectedUniversity = self.selectedUniversityName
            navigationController?.pushViewController(departmentsListTableVC, animated: true)
        }
    }
}
