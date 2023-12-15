//
//  EduResourceViewController.swift
//  Harmony
//
//  Created by Manunee Dave on 12/13/23.
//

import UIKit

class EduResourceViewController: UIViewController {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
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

extension EduResourceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width / 2) - 10
        let height: CGFloat = 350
        return CGSize(width: width, height: height)
    }
}

extension EduResourceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(resources[indexPath.row].title)
    }
}
