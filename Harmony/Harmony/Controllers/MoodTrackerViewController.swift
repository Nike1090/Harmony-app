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
    
    @IBOutlet weak var DateTextField: UITextField!
    var currentUser: User?
    var selectedMoodImageName: String?
    var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         let datePicker = UIDatePicker()
         datePicker.datePickerMode = .date
         datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
         datePicker.frame.size = CGSize(width: 0, height: 600)
         datePicker.preferredDatePickerStyle = .wheels
         
         DateTextField.inputView = datePicker
         DateTextField.text = formatDate(date: datePicker.date)
         datePicker.maximumDate = Date()
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
    
    @objc func dateChange(datePicker: UIDatePicker) {
           DateTextField.text = formatDate(date: datePicker.date)
           selectedDate = datePicker.date // Update the selected date
       }

       func formatDate(date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
           formatter.timeZone = TimeZone(identifier: "UTC") // Set the appropriate timezone
           return formatter.string(from: date)
       }

    
    @objc func selectMood(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        
        let moodImages = ["excellent", "good", "okay", "bad", "terrible"]
        let selectedImage = moodImages[imageView.tag]
        selectedMoodImageName = selectedImage
        
        // Update the SelectedFeelingImageView with the selected mood image
        SelectedFeelingImageView.image = imageView.image
        
        // Check if the selected mood name is stored properly
        print("Selected Mood: \(selectedMoodImageName ?? "No mood selected")")
    }


    @IBAction func saveFeelingButton(_ sender: Any) {
        guard let selectedMood = selectedMoodImageName, !selectedMood.isEmpty else {
            Helper.showAlert(from: self, with: "Please tell us how you feel today?")
            return
        }
        
        let db = DataStorageManager.shared
        let allMoodsByUser = db.retrieveMoods(for: currentUser?.userId ?? 0)
        guard let currentUser = currentUser else {
            // Handle the case where currentUser is nil
            return
        }
        
        var randomNumber: Int

        repeat {
            randomNumber = Int.random(in: 1...1000)
        } while allMoodsByUser.contains(where: { $0.moodId == randomNumber })
        
        // Evaluate the selected mood to determine the MoodType
        let selectedMoodType: Mood.MoodType
        
        switch selectedMood {
            case "terrible":
                selectedMoodType = .terrible
            case "excellent":
                selectedMoodType = .excellent
            case "okay":
                selectedMoodType = .okay
            case "bad":
                selectedMoodType = .bad
            case "good":
                selectedMoodType = .good
            default:
                selectedMoodType = .excellent // Default to excellent if there's no match
        }
        
        let newMood = Mood(
            moodId: randomNumber,
            userId: currentUser.userId,
            feelingText: FeelingTextField.text ?? "",
            moodType: selectedMoodType,
            date: selectedDate
        )
        
    
        // DatabaseManager.shared.saveRecord(item: newMood)
        db.saveMoodForCurrentUser(mood: newMood) { success in
            if success {
                Helper.showAlert(from: self, with: "Mood saved successfully!")
            } else {
                Helper.showAlert(from: self, with: "Failed to save mood.")
            }
        }
        Helper.showAlert(from: self, with: "Your mood saved successfully")
    }

        }
    
    

