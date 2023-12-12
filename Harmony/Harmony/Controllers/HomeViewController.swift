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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotes()
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
