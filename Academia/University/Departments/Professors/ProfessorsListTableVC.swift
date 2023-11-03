//
//  ProfessorsListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class ProfessorsListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EditProfessorDelegate, AddProfessorDelegate {
    func didAddProfessor() {
        if let fetch = selectedDepartment!.professor as? Set<Professor> {
            self.professors = Array(fetch)
        }
        self.professorTable.reloadData()
    }
    func didUpdateProfessor() {
        // Reload table view data
        self.professorTable.reloadData()
    }
    
    @IBOutlet weak var professorTable: UITableView!
    
    var professors : [Professor] = [] // Store the fetched professors
    var selectedDepartment: Department? // Store the selected department

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
        // Fetch professors for the selected department
        if let fetch = selectedDepartment!.professor as? Set<Professor> {
            self.professors = Array(fetch)
        }
        
        professorTable.delegate = self
        professorTable.dataSource = self
    }
    
    //add the Professor
    @objc func addProfessor() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let professorsVC = storyboard.instantiateViewController(withIdentifier: "ProfessorsVC") as? ProfessorsVC {
            professorsVC.delegate = self
            professorsVC.selectedDepartment = self.selectedDepartment!
            navigationController?.pushViewController(professorsVC, animated: true)
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let professorToDelete = professors[indexPath.row]
            datamanagerInstance.deleteEntity(professorToDelete)

            // After deleting, update the Professor array and reload the table view
            if let fetch = selectedDepartment!.professor as? Set<Professor> {
                self.professors = Array(fetch)
            }
            professorTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProfessorListToProfessorDetails", sender: nil)
    }
    //Pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfessorListToProfessorDetails" {
            if let indexPath = professorTable.indexPathForSelectedRow {
                // Get the selected Professor
                let selectedProfessor = professors[indexPath.row]
                
                // Pass the selected Professor to the destination view controller
                if let destinationVC = segue.destination as? EditProfessorVC {
                    destinationVC.professor = selectedProfessor
                    destinationVC.delegate = self
                }
            }
        }
    }

}
