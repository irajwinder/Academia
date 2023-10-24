//
//  UniversityListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class UniversityListTableVC: UIViewController {
    
    var universities: [University] = [] // Store the fetched universities

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Universities List"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "UniversityListTableVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self, action: #selector(addUniversity))
            }
        }
        self.universities = datamanagerInstance.fetchUniversity()
        for university in universities {
                print("University Name: \(university.universityName)")
                print("Phone Number: \(university.phoneNumber)")
                print("Address: \(university.address)")
                print("-----------------------------")
            }
    }
    
    //add the university
    @objc func addUniversity() {
        performSegue(withIdentifier: "UniversityListToAddUniversity", sender: nil)
    }

}
