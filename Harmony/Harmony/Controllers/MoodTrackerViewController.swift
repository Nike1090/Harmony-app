//
//  MoodTrackerViewController.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/12/23.
//

import UIKit

class MoodTrackerViewController: UIViewController {

    @IBOutlet weak var SelectedFeelingImageView: UIImageView!
    @IBOutlet weak var FeelingTextField: UITextField!
    @IBOutlet weak var excellentImage: UIImageView!
    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var okayImage: UIImageView!
    @IBOutlet weak var badImage: UIImageView!
    @IBOutlet weak var terribleImage: UIImageView!
    
    var currentUser: User?
    var selectedMoodImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tap gesture recognizers for each mood image view
               excellentImage.tag = 0
               goodImage.tag = 1
               okayImage.tag = 2
               badImage.tag = 3
               terribleImage.tag = 4
        
        // Set tap gesture recognizers for each mood image view
                let tapGestureRecognizers: [UIGestureRecognizer] = [
                    UITapGestureRecognizer(target: self, action: #selector(selectMood(_:))),
                    UITapGestureRecognizer(target: self, action: #selector(selectMood(_:))),
                    UITapGestureRecognizer(target: self, action: #selector(selectMood(_:))),
                    UITapGestureRecognizer(target: self, action: #selector(selectMood(_:))),
                    UITapGestureRecognizer(target: self, action: #selector(selectMood(_:)))
                ]
                
        let imageViews = [excellentImage, goodImage, okayImage, badImage, terribleImage]
                for (index, imageView) in imageViews.enumerated() {
                    imageView?.isUserInteractionEnabled = true
                    imageView?.addGestureRecognizer(tapGestureRecognizers[index])
                }
    }
    
    @objc func selectMood(_ sender: UITapGestureRecognizer) {
            guard let imageView = sender.view as? UIImageView else { return }
            
            let moodImages = ["excellent", "good", "okay", "bad", "terrible"]
            let selectedImage = moodImages[imageView.tag]
            selectedMoodImageName = selectedImage
            
            // Update the SelectedFeelingImageView with the selected mood image
            SelectedFeelingImageView.image = imageView.image
        }
    

    @IBAction func saveFeelingButton(_ sender: Any) {
            guard let selectedMood = selectedMoodImageName, !selectedMood.isEmpty else {
                Helper.showAlert(from: self, with: "Please tell us how you feel today?")
                return
            }

            let currentDate = Date()
            let db = DataStorageManager.shared
            let allMoodsByUser = DataStorageManager.shared.retrieveMoods(for: currentUser!.userId)
            
            var randomNumber: Int
            repeat {
                randomNumber = Int.random(in: 1...100000)
            } while allMoodsByUser.contains(where: { $0.moodId == randomNumber })
            
            
        
            let newMood = Mood(moodId: randomNumber, userId: currentUser?.userId ?? 0, feelingText: FeelingTextField.text ?? "", moodType: Mood.MoodType(rawValue: selectedMood) ?? .excellent, date: currentDate)


            db.saveMoodForCurrentUser(mood: newMood)
            Helper.showAlert(from: self, with: "Mood saved successfully!")
         
        }
    
    
}
