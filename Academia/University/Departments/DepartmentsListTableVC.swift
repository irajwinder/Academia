//
//  DepartmentsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class DepartmentsListTableVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Department List"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "DepartmentsListTableVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self, action: #selector(addDepartment))
            }
        }
    }
    
    //add the department
    @objc func addDepartment() {
        performSegue(withIdentifier: "DepartmentListToAddDepartment", sender: nil)
    }
}
