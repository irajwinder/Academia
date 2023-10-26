//
//  ProfessorsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class ProfessorsListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var professorTable: UITableView!
    
    var professors : [Professor] = [] // Store the fetched professors

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Professor List"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "ProfessorsListTableVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self, action: #selector(addProfessor))
            }
        }
        
        self.professors = datamanagerInstance.fetchProfessor()
        
        professorTable.delegate = self
        professorTable.dataSource = self
    }
    
    //add the Professor
    @objc func addProfessor() {
        performSegue(withIdentifier: "ProfessorListToAddProfessor", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professors.count // Return the count of fetched professors
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ProfessorCell", for: indexPath) as! ProfessorsListTableCell
        
        let professor = professors[indexPath.row]
        if let name = professor.value(forKeyPath: "professorName") as? String {
            cell.professorName.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "DepartmentListToAddProfessor", sender: nil)
    }

}
