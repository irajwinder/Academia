//
//  DepartmentsVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

protocol AddDepartmentDelegate: AnyObject {
    func didAddDepartment()
}

class DepartmentsVC: UIViewController {
    
    @IBOutlet weak var departmentName: UITextField!

    weak var delegate: AddDepartmentDelegate?
    
    var selectedUniversity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Department"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "DepartmentsVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .save, target: self, action: #selector(saveDepartment))
            }
        }
    }
    
    //Save the Department to Core Data
    @objc func saveDepartment() {
        //Validate before saving
        guard let departmentName = self.departmentName.text, Validation.isValidName(departmentName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        //Save the data
        datamanagerInstance.saveDepartment(
            universityName: selectedUniversity!, 
            departmentName: departmentName,
            entity: "Department"
        )
        // Call delegate method
        delegate?.didAddDepartment()
        navigationController?.popViewController(animated: true)
    }

}
