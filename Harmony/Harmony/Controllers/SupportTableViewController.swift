//
//  SupportTableViewController.swift
//  Harmony
//
//  Created by Manunee Dave on 12/15/23.
//

import UIKit

class DoctorsTableViewController: UITableViewController {
    var doctors: [Doctor] = [
        Doctor(name: "Dr. Jenny Miller", phoneNumber: "123-456-7890", address: "123 Main St", photo: UIImage(named: "doctor1")),
        
        Doctor(name: "Dr. John Smith", phoneNumber: "234-567-8901", address: "456 Elm St", photo: UIImage(named: "doctors2")),
        
        Doctor(name: "Dr. Emi Johnson", phoneNumber: "345-678-9012", address: "789 Oak Ave", photo: UIImage(named: "doctor3")),
        
        Doctor(name: "Dr. Michael Brown", phoneNumber: "456-789-0123", address: "101 Pine Rd", photo: UIImage(named: "doctors4")),
        
        Doctor(name: "Dr. Sarah Miller", phoneNumber: "567-890-1234", address: "202 Birch Ln", photo: UIImage(named: "doctors5")),
        
        Doctor(name: "Dr. Susan Miller", phoneNumber: "567-890-1234", address: "202 Birch Ln", photo: UIImage(named: "doctors6"))
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
