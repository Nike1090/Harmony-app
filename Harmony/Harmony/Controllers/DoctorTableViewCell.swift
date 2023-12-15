//
//  DoctorTableViewCell.swift
//  Harmony
//
//  Created by Manunee Dave on 12/15/23.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var callButton: UIButton!
    
    
    var phoneNumber: String?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            doctorImageView.layer.cornerRadius = doctorImageView.frame.height / 2
            doctorImageView.clipsToBounds = true
        }

        @IBAction func callButtonTapped(_ sender: UIButton) {
            if let number = phoneNumber, let url = URL(string: "tel://\(number)") {
                        if UIApplication.shared.canOpenURL(url) {
                            // Construct the alert for calling
                            let alert = UIAlertController(title: "Make a Call", message: "Do you want to call \(number)?", preferredStyle: .alert)
                            let callAction = UIAlertAction(title: "Call", style: .default) { _ in
                                UIApplication.shared.open(url)
                            }
                            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                            alert.addAction(callAction)
                            alert.addAction(cancelAction)

                            // Present the alert using Helper's method
                            Helper.showAlertforCall(alert)
                        } else {
                            let alert = UIAlertController(title: "Cannot make a Call", message: "Device is not compatible to make calls", preferredStyle: .alert)
                            Helper.showAlertforCall(alert)
                        }
                    }
                }
    
    func configure(with doctor: Doctor) {
        nameLabel.text = doctor.name
        phoneNumberLabel.text = doctor.phoneNumber
        addressLabel.text = doctor.address
        doctorImageView.image = doctor.photo
        phoneNumber = doctor.phoneNumber
    }
}


        
