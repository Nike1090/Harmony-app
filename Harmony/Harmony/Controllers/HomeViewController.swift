//
//  HomeViewController.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    var currentUser: User?
    @IBOutlet weak var GreetLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotes()
        
        self.GreetLabel.text = "Hello, \(String(describing: currentUser!.name))"
       
        // Do any additional setup after loading the view.
    }
    

    
    
    
    func fetchQuotes() {
            NetworkingManager.shared.fetchQuotes { quotes, error in
                if let error = error {
                    print("Error fetching quotes: \(error.localizedDescription)")
                    return
                }
                
                if let quotes = quotes, let firstQuote = quotes.first {
                    DispatchQueue.main.async {
                    
                        self.quoteLabel.text = firstQuote.q
                        self.authorLabel.text = "- \(firstQuote.a)"
                    }
                }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "MoodTrackerViewController" {
                if let moodTrackerVC = segue.destination as? MoodTrackerViewController {
                    moodTrackerVC.currentUser = currentUser
                }
            }
    
    
        
        
        }
    
    
   

}
