//
//  CoursesListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class CoursesListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var courseTable: UITableView!
    
    var courses : [Course] = [] // Store the fetched courses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Course List"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "CoursesListTableVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self, action: #selector(addCourse))
            }
        }
        
        self.courses = datamanagerInstance.fetchCourse()
        
        courseTable.delegate = self
        courseTable.dataSource = self
    }
    
    //add the Course
    @objc func addCourse() {
        performSegue(withIdentifier: "CourseListToAddCourse", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count // Return the count of fetched courses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CoursesListTableCell
        
        let course = courses[indexPath.row]
        if let name = course.value(forKeyPath: "courseName") as? String {
            cell.courseName.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CourseListToAddStudent", sender: nil)
    }
    
}
