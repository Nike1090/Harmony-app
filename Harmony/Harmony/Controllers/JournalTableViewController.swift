//
//  JournalTableViewController.swift
//  Harmony
//
//  Created by Karicharla sricharan on 12/14/23.
//

import UIKit

class JournalTableViewController: UITableViewController {

    var currentUser: User?
    let db = DataStorageManager.shared
    var userMoods: [Mood] = [] // Array to store user's moods
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "JournalTableCell")
        // Retrieve the user's moods based on their userId
       
        if let user = currentUser {
            userMoods = db.retrieveMoods(for: user.userId)
        }
        print(currentUser?.name ?? "hi")
        print(userMoods.count)
        tableView.reloadData() // Reload the table view to reflect the changes
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming you have only one section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMoods.count // Number of rows based on the user's moods
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // Adjust the height according to your UI design
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalTableCell", for: indexPath)

        // Get the mood for the current row
        let mood = userMoods[indexPath.row]
        
        // Configure the cell with mood data
        if let moodType = Mood.MoodType(rawValue: mood.moodType.rawValue) {
            var imageName: String = ""
            switch moodType {
            case .excellent: imageName = "excellent"
            case .good: imageName = "good"
            case .okay: imageName = "okay"
            case .bad: imageName = "bad"
            case .terrible: imageName = "terrible"
            }
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        // Create labels for feeling text and date
        let feelingLabel = UILabel()
        feelingLabel.text = mood.feelingText
        feelingLabel.translatesAutoresizingMaskIntoConstraints = false
        feelingLabel.font = .boldSystemFont(ofSize: 20)
        feelingLabel.font = UIFont(name: "Arial-BoldMT", size: 18) // Adjust the size as needed
        cell.contentView.addSubview(feelingLabel)
        
        
        let dateLabel = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" // Customize date format if needed
        dateLabel.text = dateFormatter.string(from: mood.date)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Arial-BoldMT", size: 12)
        cell.contentView.addSubview(dateLabel)
        
        // Set constraints for labels
        NSLayoutConstraint.activate([
            feelingLabel.leadingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: 16),
            feelingLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            feelingLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            
            dateLabel.leadingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: feelingLabel.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
        ])

        return cell
    }


    // Other table view delegate methods...
}
