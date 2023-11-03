//
//  ProfessorsVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

protocol AddProfessorDelegate: AnyObject {
    func didAddProfessor()
}

class ProfessorsVC: UIViewController {
    
    @IBOutlet weak var professorName: UITextField!
    @IBOutlet weak var professorNumber: UITextField!
    
    weak var delegate: AddProfessorDelegate?
    
    var selectedDepartment: Department?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Professor"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "ProfessorsVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .save, target: self, action: #selector(saveProfessor))
            }
        }
    }
    
    //Save the Professor to Core Data
    @objc func saveProfessor() {
        //Validate before saving
        guard let professorName = professorName.text, Validation.isValidName(professorName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        guard let professorNumber = self.professorNumber.text, Validation.isValidPhoneNumber(professorNumber) else {
            Validation.showAlert(on: self, with: "Invalid Number", message: "Please enter a valid phone Number.")
            return
        }
        
        //Save the data
        guard let selectedDepartment = selectedDepartment else {
            print("Error: Could not fetch!")
            return
        }
        datamanagerInstance.saveProfessor(
            departmentName: selectedDepartment,
            professorName: professorName,
            phoneNumber: professorNumber
        )
        // Call delegate method
        delegate?.didAddProfessor()
        navigationController?.popViewController(animated: true)
    }
}
