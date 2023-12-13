//
//  ResourceCollectionViewCell.swift
//  Harmony
//
//  Created by Manunee Dave on 12/13/23.
//

import UIKit

class ResourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var resourceImage: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    
    func setup(with resource: Resources) {
            resourceImage.image = resource.image
            title_label.text = resource.title
        }
}
