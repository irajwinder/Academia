//
//  DepartmentsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class DepartmentsListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var departmentTable: UITableView!
    
    var departments : [Department] = [] // Store the fetched departments
    
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
        
        self.departments = datamanagerInstance.fetchDepartment()
        
        departmentTable.delegate = self
        departmentTable.dataSource = self
    }
    
    //add the department
    @objc func addDepartment() {
        performSegue(withIdentifier: "DepartmentListToAddDepartment", sender: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DepartmentListToAddProfessor", sender: nil)
    }
}
