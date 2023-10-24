//
//  UniversityVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class UniversityVC: UIViewController {
    
    @IBOutlet weak var universityName: UITextField!
    @IBOutlet weak var universityPhoneNumber: UITextField!
    @IBOutlet weak var universityAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add University"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "UniversityVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .save, target: self, action: #selector(saveUniversity))
            }
        }
        
    }
    
    //Save the university to Core Data
    @objc func saveUniversity() {
        //Validate before saving
        guard let universityName = universityName.text, Validation.isValidName(universityName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
//        guard let universityPhoneNumber = universityPhoneNumber.text, Validation.isValidPhoneNumber(universityPhoneNumber) else {
//            Validation.showAlert(on: self, with: "Invalid Number", message: "Please enter a valid phone Number.")
//            return
//        }
        
        guard let universityAddress = universityAddress.text, Validation.isValidName(universityAddress) else {
            Validation.showAlert(on: self, with: "Invalid Address", message: "Please enter a valid Address.")
            return
        }
        
        datamanagerInstance.saveUniversity(
            universityName: universityName,
            phoneNumber: universityPhoneNumber.text ?? "",
            location: universityAddress
        )
        navigationController?.popViewController(animated: true)
    }

}
