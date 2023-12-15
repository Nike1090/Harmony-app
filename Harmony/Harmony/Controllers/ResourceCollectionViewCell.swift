//
//  ResourceCollectionViewCell.swift
//  Harmony
//
//  Created by Manunee Dave on 12/13/23.
//

import UIKit
import AVFoundation

class ResourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title_label: UILabel!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isPlaying = false

    private lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.backgroundColor = UIColor.systemGray // Added background color
        button.setTitleColor(UIColor.white, for: .normal) // Text color
        button.layer.cornerRadius = 25 // Rounded corners
        button.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupPlayPauseButton()
    }

    private func setupPlayerLayer() {
        guard playerLayer == nil else { return }
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill // Change to resizeAspectFill
        if let playerLayer = playerLayer {
            contentView.layer.insertSublayer(playerLayer, at: 0)
        }
    }

    private func configurePlayer(with url: URL) {
        player = AVPlayer(url: url)
        setupPlayerLayer()
        playerLayer?.player = player
    }

    func setup(with resource: Resources) {
        title_label.text = resource.title
        guard let url = resource.videoURL else {
            print("Invalid URL for resource: \(resource.title)")
            return
        }
        configurePlayer(with: url)
    }

    private func setupPlayPauseButton() {
        contentView.addSubview(playPauseButton)
        let buttonSize: CGFloat = 50 // Size of the button
        playPauseButton.frame = CGRect(
            x: (contentView.bounds.width - buttonSize) / 2,
            y: (contentView.bounds.height - buttonSize) / 2,
            width: buttonSize,
            height: buttonSize
        )
        playPauseButton.layer.cornerRadius = buttonSize / 2 // Optional, for a rounded button
        playPauseButton.clipsToBounds = true
        bringSubviewToFront(playPauseButton)
    }

    @objc private func togglePlayPause() {
        if isPlaying {
            player?.pause()
            playPauseButton.setTitle("Play", for: .normal)
        } else {
            player?.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }
        isPlaying.toggle()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Define the height for the video and title label
        let videoHeight = contentView.bounds.height - 50 // 50 points for title label height
        let labelHeight: CGFloat = 50

        // Set the frame for the playerLayer
        playerLayer?.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: videoHeight)

        // Set the frame for the title label
        title_label.frame = CGRect(x: 30, y: videoHeight, width: contentView.bounds.width - 60, height: labelHeight)

        // Update the Play/Pause button position
        let buttonSize: CGFloat = 50
        playPauseButton.frame = CGRect(
            x: (contentView.bounds.width - buttonSize) / 2,
            y: (videoHeight - buttonSize) / 2,
            width: buttonSize,
            height: buttonSize
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player?.replaceCurrentItem(with: nil)
        isPlaying = false
        playPauseButton.setTitle("Play", for: .normal)
    }
}

