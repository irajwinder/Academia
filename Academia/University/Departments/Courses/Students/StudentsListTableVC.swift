//
//  StudentsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class StudentsListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        self.students = datamanagerInstance.fetchStudent()
        
        studentTable.delegate = self
        studentTable.dataSource = self
    }
    
    //add the Student
    @objc func addStudent() {
        performSegue(withIdentifier: "StudentListToAddStudent", sender: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CourseListToAddStudent", sender: nil)
    }
}
