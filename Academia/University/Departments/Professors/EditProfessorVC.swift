//
//  EditProfessorVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/27/23.
//

import UIKit

protocol EditProfessorDelegate: AnyObject {
    func didUpdateProfessor()
}

class EditProfessorVC: UIViewController {
    
    @IBOutlet weak var editProfessorName: UITextField!
    @IBOutlet weak var editProfessorNumber: UITextField!
    
    var professor: Professor?
    var isEditingEnabled = false
    weak var delegate: EditProfessorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Professor Details"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "EditProfessorVC" {
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
        editProfessorName.isEnabled = isEditingEnabled
        editProfessorNumber.isEnabled = isEditingEnabled
        
        //Set the Professor info
        if let professor = professor {
            editProfessorName.text = professor.professorName
            editProfessorNumber.text = String(professor.phoneNumber)
        }
    }
    
    @objc func editButton() {
        //Enable editing and change button to "Save"
        isEditingEnabled = true
        viewDidLoad() // Refresh the view to apply changes
    }
    
    @objc func saveButton() {
        //Validate before saving
        guard let professorName = self.editProfessorName.text, Validation.isValidName(professorName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        guard let professorPhoneNumber = self.editProfessorNumber.text, Validation.isValidPhoneNumber(professorPhoneNumber) else {
            Validation.showAlert(on: self, with: "Invalid Number", message: "Please enter a valid phone Number.")
            return
        }
        
        // Save changes and disable editing
        isEditingEnabled = false
                
        guard let professor = professor else {
            // Handle the case when the professor object is nil
            print("Error: professor object is nil.")
            return
        }
        datamanagerInstance.updateProfessor(
            professor: professor,
            editProfessorName: professorName,
            editProfessorNumber: professorPhoneNumber
        )
        // Call delegate method
        delegate?.didUpdateProfessor()
        navigationController?.popViewController(animated: true)
    }

}
