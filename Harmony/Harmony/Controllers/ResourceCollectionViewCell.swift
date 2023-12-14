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
        playerLayer?.videoGravity = .resizeAspect
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
        playPauseButton.frame = CGRect(x: 10, y: contentView.bounds.height - 60, width: 80, height: 50)
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
        playerLayer?.frame = contentView.bounds
        playPauseButton.frame = CGRect(x: 10, y: contentView.bounds.height - 60, width: 80, height: 50)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player?.replaceCurrentItem(with: nil)
        isPlaying = false
        playPauseButton.setTitle("Play", for: .normal)
    }
}

