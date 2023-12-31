//
//  CoursesListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class CoursesListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EditCourseDelegate, AddCourseDelegate {
    func didAddCourse() {
        if let fetch = selectedDepartment!.course as? Set<Course> {
            self.courses = Array(fetch)
        }
        self.courseTable.reloadData()
    }
    func didUpdateCourse() {
        // Reload table view data
        self.courseTable.reloadData()
    }
    
    @IBOutlet weak var courseTable: UITableView!
    
    var courses : [Course] = [] // Store the fetched courses
    var selectedDepartment: Department? // Store the selected department
    
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
        // Fetch courses for the selected department
        if let fetch = selectedDepartment!.course as? Set<Course> {
            self.courses = Array(fetch)
        }
        
        courseTable.delegate = self
        courseTable.dataSource = self
    }
    
    //add the Course
    @objc func addCourse() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let coursesVC = storyboard.instantiateViewController(withIdentifier: "CoursesVC") as? CoursesVC {
            coursesVC.delegate = self
            coursesVC.selectedDepartment = self.selectedDepartment!
            navigationController?.pushViewController(coursesVC, animated: true)
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let courseToDelete = courses[indexPath.row]
            datamanagerInstance.deleteEntity(courseToDelete)

            // After deleting, update the course array and reload the table view
            if let fetch = selectedDepartment!.course as? Set<Course> {
                self.courses = Array(fetch)
            }
            self.courseTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CourseListToCourseDetails", sender: nil)
    }
    //Pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CourseListToCourseDetails" {
            if let indexPath = courseTable.indexPathForSelectedRow {
                // Get the selected course
                let selectedCourse = courses[indexPath.row]
                
                // Pass the selected course to the destination view controller
                if let destinationVC = segue.destination as? EditCourseVC {
                    destinationVC.selectedCourse = selectedCourse
                    destinationVC.selectedDepartment = self.selectedDepartment
                    destinationVC.delegate = self
                }
            }
        }
    }
    
}
