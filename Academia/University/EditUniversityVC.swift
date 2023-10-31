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
                // Inside viewDidLoad
                let threeDotsButton = UIButton(type: .system)
                threeDotsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
                threeDotsButton.addTarget(self, action: #selector(showPopoverMenu), for: .touchUpInside)
                let threeDotsBarButtonItem = UIBarButtonItem(customView: threeDotsButton)
                self.navigationItem.rightBarButtonItem = threeDotsBarButtonItem
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
    }
    
    @objc func showPopoverMenu(sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isEditingEnabled {
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
                self.saveButton()
            })
            optionMenu.addAction(saveAction)
        } else {
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { _ in
                self.editButton()
            })
            let departmentAction = UIAlertAction(title: "Department(s)", style: .default, handler: { _ in
                self.department()
            })
            optionMenu.addAction(editAction)
            optionMenu.addAction(departmentAction)
        }
        
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
