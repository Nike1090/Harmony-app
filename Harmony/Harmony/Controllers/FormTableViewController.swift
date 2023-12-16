//
//  FormTableViewController.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/15/23.
//

import UIKit

class FormTableViewController: UITableViewController {

    var formRows: [Form] = []
    let db = DataStorageManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        formRows = db.retrieveForms()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "formCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formRows.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           // Set the height of each table view cell
           return 100 // Adjust the value according to your preference
       }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCell", for: indexPath)

        let form = formRows[indexPath.row]

        let textFieldLabel = UILabel()
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.font = UIFont.systemFont(ofSize: 16)
        textFieldLabel.text = "\(form.textField1), \(form.textField2),  \(form.textField3)"
        cell.contentView.addSubview(textFieldLabel)

        let textFieldDetailLabel = UILabel()
        textFieldDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldDetailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        textFieldDetailLabel.text = "\(form.textField4),  \(form.textField5),  \(form.textField6)"
        cell.contentView.addSubview(textFieldDetailLabel)

        NSLayoutConstraint.activate([
            textFieldLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            textFieldLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            textFieldLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),

            textFieldDetailLabel.topAnchor.constraint(equalTo: textFieldLabel.bottomAnchor, constant: 8),
            textFieldDetailLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            textFieldDetailLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            textFieldDetailLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
        ])

        return cell
    }

   
}
