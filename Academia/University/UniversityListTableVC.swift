//
//  UniversityListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class UniversityListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EditUniversityDelegate, AddUniversityDelegate {
    func didAddUniversity() {
        let fetch = datamanagerInstance.fetchAllData().universities
        self.universities = fetch
        self.universityTable.reloadData()
    }
    
    func didUpdateUniversity() {
        // Reload table view data
        self.universityTable.reloadData()
    }
    
    @IBOutlet weak var universityTable: UITableView!
    
    var universities: [University] = [] // Store the fetched universities

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Universities List"
        
        // Check the current view controller's identifier
        if let currentIdentifier = restorationIdentifier {
            if currentIdentifier == "UniversityListTableVC" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self, action: #selector(addUniversity))
            }
        }
        let fetch = datamanagerInstance.fetchAllData().universities
        self.universities = fetch
        
        universityTable.delegate = self
        universityTable.dataSource = self
    }
    
    //add the university
    @objc func addUniversity() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let universityVC = storyboard.instantiateViewController(withIdentifier: "UniversityVC") as? UniversityVC {
            universityVC.delegate = self
            navigationController?.pushViewController(universityVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count // Return the count of fetched Universities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath) as! UniversityListTableCell
        
        let university = universities[indexPath.row]
        if let name = university.value(forKeyPath: "universityName") as? String {
            cell.universityName.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let universityToDelete = universities[indexPath.row]
            datamanagerInstance.deleteEntity(universityToDelete)

            // After deleting, update the universities array and reload the table view
            let fetch = datamanagerInstance.fetchAllData().universities
            self.universities = fetch
            self.universityTable.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UniversityListToEditUniversity", sender: nil)
    }
    //Pass user data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UniversityListToEditUniversity" {
            if let indexPath = universityTable.indexPathForSelectedRow {
                // Get the selected university
                let selectedUniversity = universities[indexPath.row]
                
                // Pass the selected University to the destination view controller
                if let destinationVC = segue.destination as? EditUniversityVC {
                    destinationVC.university = selectedUniversity
                    destinationVC.delegate = self
                }
            }
        }
    }
    
}
