//
//  StudentsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class StudentsListTableVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Student List"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "StudentsListTableVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self, action: #selector(addStudent))
            }
        }
    }
    
    //add the Student
    @objc func addStudent() {
        performSegue(withIdentifier: "StudentListToAddStudent", sender: nil)
    }

}
