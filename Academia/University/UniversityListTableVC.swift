//
//  UniversityListTableVC.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import UIKit

class UniversityListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        self.universities = datamanagerInstance.fetchUniversity()
        
        universityTable.delegate = self
        universityTable.dataSource = self
    }
    
    //add the university
    @objc func addUniversity() {
        performSegue(withIdentifier: "UniversityListToAddUniversity", sender: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UniversityListToAddDepartment", sender: nil)
    }
}
