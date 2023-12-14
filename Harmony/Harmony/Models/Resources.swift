//
//  Resources.swift
//  Harmony
//
//  Created by Manunee Dave on 12/13/23.
//

import UIKit

public struct Resources {
    let title: String
    let videoURL: URL?
}

public let resources: [Resources] = [
    Resources(title: "This is Video 1", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")), // Replace with actual direct video file URL
    Resources(title: "This is Video 2", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"))  // Replace with actual direct video file URL
]

