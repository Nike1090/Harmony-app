//
//  EduResourceViewController.swift
//  Harmony
//
//  Created by Manunee Dave on 12/13/23.
//

import UIKit

class EduResourceViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        collectionView.dataSource = self
        
    }
    


}

extension EduResourceViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resources.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResourceCollectionViewCell", for: indexPath) as! ResourceCollectionViewCell
            cell.setup(with: resources[indexPath.row])
            return cell
        }
    
}
