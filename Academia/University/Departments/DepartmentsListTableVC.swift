//
//  DepartmentsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class DepartmentsListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EditDepartmentDelegate, AddDepartmentDelegate {
    func didAddDepartment() {
        let fetch = datamanagerInstance.fetchDepartmentsFromUniversity(universityName: selectedUniversity!)
        self.departments = fetch
        self.departmentTable.reloadData()
    }
    
    func didUpdateDepartment() {
        // Reload table view data
        self.departmentTable.reloadData()
    }
    
    
    @IBOutlet weak var departmentTable: UITableView!
    
    var departments : [Department] = [] // Store the fetched departments
    var selectedUniversity: String? // Store the selected university
    
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
        // Fetch departments for the selected university
        let fetch = datamanagerInstance.fetchDepartmentsFromUniversity(universityName: selectedUniversity!)
        self.departments = fetch
        
        departmentTable.delegate = self
        departmentTable.dataSource = self
    }
    
    //add the department
    @objc func addDepartment() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let departmentsVC = storyboard.instantiateViewController(withIdentifier: "DepartmentsVC") as? DepartmentsVC {
            departmentsVC.delegate = self
            departmentsVC.selectedUniversity = self.selectedUniversity!
            navigationController?.pushViewController(departmentsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments.count // Return the count of fetched departments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath) as! DepartmentsListTableCell
        
        let department = departments[indexPath.row]
        if let name = department.value(forKeyPath: "departmentName") as? String {
            cell.departmentName.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let departmentToDelete = departments[indexPath.row]
            datamanagerInstance.deleteEntity(departmentToDelete)

            // After deleting, updates the Department array and reload the table view
            let fetch = datamanagerInstance.fetchDepartmentsFromUniversity(universityName: selectedUniversity!)
            self.departments = fetch
            self.departmentTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DepartmentListToDepartmentDetails", sender: nil)
    }
    //Pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DepartmentListToDepartmentDetails" {
            if let indexPath = departmentTable.indexPathForSelectedRow {
                // Get the selected department
                let selectedDepartment = departments[indexPath.row]
                
                // Pass the selected Department to the destination view controller
                if let destinationVC = segue.destination as? EditDepartmentVC {
                    destinationVC.department = selectedDepartment
                    destinationVC.selectedDepartmentName = selectedDepartment.departmentName!
                    destinationVC.delegate = self
                }
            }
        }
    }
    
}
