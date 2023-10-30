//
//  StudentsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class StudentsListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EditStudentDelegate, AddStudentDelegate {
    func didAddStudent() {
        let fetch = datamanagerInstance.fetchStudent()
        self.students = fetch
        self.studentTable.reloadData()
    }
    func didUpdateStudent() {
        // Reload table view data
        self.studentTable.reloadData()
    }
    
    @IBOutlet weak var studentTable: UITableView!
    
    var students : [Student] = [] // Store the fetched students
    
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
        
        let fetch = datamanagerInstance.fetchStudent()
        self.students = fetch
        
        studentTable.delegate = self
        studentTable.dataSource = self
    }
    
    //add the Student
    @objc func addStudent() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let studentsVC = storyboard.instantiateViewController(withIdentifier: "StudentsVC") as? StudentsVC {
            studentsVC.delegate = self
            navigationController?.pushViewController(studentsVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count // Return the count of fetched students
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentsListTableCell
        
        let student = students[indexPath.row]
        if let name = student.value(forKeyPath: "studentName") as? String {
            cell.studentName.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let studentToDelete = students[indexPath.row]
            datamanagerInstance.deleteEntity(studentToDelete)

            // After deleting, update the student array and reload the table view
            let fetch = datamanagerInstance.fetchStudent()
            self.students = fetch
            self.studentTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StudentListToStudentDetails", sender: nil)
    }
    //Pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StudentListToStudentDetails" {
            if let indexPath = studentTable.indexPathForSelectedRow {
                // Get the selected student
                let selectedStudent = students[indexPath.row]
                
                // Pass the selected student to the destination view controller
                if let destinationVC = segue.destination as? EditStudentVC {
                    destinationVC.student = selectedStudent
                    destinationVC.delegate = self
                }
            }
        }
    }
}
