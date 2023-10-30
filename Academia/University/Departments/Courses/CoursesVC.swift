//
//  CoursesVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

protocol AddCourseDelegate: AnyObject {
    func didAddCourse()
}

class CoursesVC: UIViewController {
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseCode: UITextField!
    @IBOutlet weak var courseSemester: UITextField!
    
    weak var delegate: AddCourseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Course"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "CoursesVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .save, target: self, action: #selector(saveCourse))
            }
        }
    }
    
    //Save the Course to Core Data
    @objc func saveCourse() {
        //Validate before saving
        guard let courseName = self.courseName.text, Validation.isValidName(courseName) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid name.")
            return
        }
        
        guard let courseCode = self.courseCode.text, Validation.isValidNumber(Int(courseCode)) else {
            Validation.showAlert(on: self, with: "Invalid Code", message: "Please enter a valid Code.")
            return
        }
        
        guard let courseSemester = self.courseSemester.text, Validation.isValidName(courseSemester) else {
            Validation.showAlert(on: self, with: "Invalid Name", message: "Please enter a valid Semester.")
            return
        }
        
        //Save the data
        datamanagerInstance.saveCourse(
            courseName: courseName,
            courseCode: courseCode,
            courseSemester: courseSemester
        )
        // Call delegate method
        delegate?.didAddCourse()
        navigationController?.popViewController(animated: true)
    }
    
}
