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

class CoursesVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseCode: UITextField!
    @IBOutlet weak var courseSemester: UITextField!
    @IBOutlet weak var courseAdvisor: UITextField!
    @IBOutlet weak var courseAdvisorPicker: UIPickerView!
    
    weak var delegate: AddCourseDelegate?
    
    var selectedDepartment: String?
    var professorNames: [Professor] = [] // hold the professor names
    
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
        
        // Fetch professors for the selected department
        let fetch = datamanagerInstance.fetchProfessorsFromDepartment(departmentName: selectedDepartment!)
        self.professorNames = fetch
        
        // Set the data source and delegate for the UIPickerView.
        courseAdvisorPicker.dataSource = self
        courseAdvisorPicker.delegate = self
        
        // Set the delegate for the courseAdvisor text field
        courseAdvisor.delegate = self
        courseAdvisorPicker.isHidden = true
    }
    
    // Show the picker when the courseAdvisor text field is clicked
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == courseAdvisor {
            courseAdvisorPicker.isHidden = false
            courseAdvisor.resignFirstResponder() // Dismiss the keyboard
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
        
        guard let courseAdvisor = self.courseAdvisor.text, Validation.isValidName(courseAdvisor) else {
            Validation.showAlert(on: self, with: "Invalid Advisor", message: "Please select a valid Advisor.")
            return
        }
        
        //Save the data
        datamanagerInstance.saveCourse(
            departmentName: selectedDepartment!, 
            courseName: courseName,
            courseCode: courseCode,
            courseSemester: courseSemester, 
            courseAdvisor: courseAdvisor
        )
        // Call delegate method
        delegate?.didAddCourse()
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return professorNames.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return professorNames[row].professorName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Set the selected value from the picker to the courseAdvisor text field
        courseAdvisor.text = professorNames[row].professorName
        courseAdvisorPicker.isHidden = true
       }
    
}
