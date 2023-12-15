//
//  SupportTableViewController.swift
//  Harmony
//
//  Created by Manunee Dave on 12/15/23.
//

import UIKit

class DoctorsTableViewController: UITableViewController {
    var doctors: [Doctor] = [
        Doctor(name: "Dr. Jane Doe", phoneNumber: "123-456-7890", address: "123 Main St", photo: UIImage(named: "doctor1")),
        // Add more doctors
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell", for: indexPath) as! DoctorTableViewCell
        cell.configure(with: doctors[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125 // Adjust as needed
    }
}
