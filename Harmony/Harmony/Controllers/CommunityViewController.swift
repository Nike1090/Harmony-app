//
//  CommunityViewController.swift
//  Harmony
//
//  Created by Karicharla sricharan on 12/15/23.
//

import UIKit
import AVFoundation


class CommunityViewController: UIViewController {

    var player: AVPlayer?
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Function to play or pause audio when the button is tapped
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        if isPlaying {
            pauseAudio()
            sender.setTitle("Play", for: .normal)
        } else {
            playAudioFromURL()
            sender.setTitle("Pause", for: .normal)
        }
        isPlaying = !isPlaying
    }

    // Function to play audio from the internet
    func playAudioFromURL() {
        // URL of the audio file from the internet
        if let audioURL = URL(string: "https://myhealth.alberta.ca/Alberta/Alberta%20Images/Audio-Tracks/deep-breathing.mp3") {
            player = AVPlayer(url: audioURL)
            player?.play()
        }
    }

    // Function to pause audio
    func pauseAudio() {
        player?.pause()
    }

    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        // Example: Passing data to the destination view controller
//        if segue.identifier == "YourSegueIdentifier" {
//            if let destinationViewController = segue.destination as? YourDestinationViewController {
//                destinationViewController.player = self.player
//            }
//        }
//    }
}
