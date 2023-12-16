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

    let forestUrl = "https://www.gstatic.com/voice_delight/sounds/long/forest.mp3"
    let rainUrl = "https://www.gstatic.com/voice_delight/sounds/long/rain.mp3"
    let whiteNoiseUrl = "https://www.gstatic.com/voice_delight/sounds/long/pink_noise.mp3"
    let countryNightUrl = "https://www.gstatic.com/voice_delight/sounds/long/country_night.mp3"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Function to play or pause forest audio
    @IBAction func playPauseButtonTapped1(_ sender: UIButton) {
        handleAudioPlayback(urlString: forestUrl, button: sender)
    }

    // Function to play or pause rain audio
    @IBAction func playPauseButtonTapped2(_ sender: UIButton) {
        handleAudioPlayback(urlString: rainUrl, button: sender)
    }

    // Function to play or pause white noise audio
    @IBAction func playPauseButtonTapped3(_ sender: UIButton) {
        handleAudioPlayback(urlString: whiteNoiseUrl, button: sender)
    }

    // Function to play or pause country night audio
    @IBAction func playPauseButtonTapped4(_ sender: UIButton) {
        handleAudioPlayback(urlString: countryNightUrl, button: sender)
    }

    // Function to handle audio playback for each URL
    func handleAudioPlayback(urlString: String, button: UIButton) {
        if isPlaying {
            pauseAudio()
            button.setTitle("Play", for: .normal)
        } else {
            playAudioFromURL(urlString: urlString)
            button.setTitle("Pause", for: .normal)
        }
        isPlaying = !isPlaying
    }

    // Function to play audio from the provided URL
    func playAudioFromURL(urlString: String) {
        if let audioURL = URL(string: urlString) {
            player = AVPlayer(url: audioURL)
            player?.play()
        }
    }

    // Function to pause audio
    func pauseAudio() {
        player?.pause()
    }
}
