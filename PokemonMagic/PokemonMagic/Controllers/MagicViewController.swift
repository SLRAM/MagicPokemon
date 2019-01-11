//
//  MagicViewController.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {
    var cards = [MagicInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.magicCollectionView.reloadData()
            }
        }
    }

    @IBOutlet weak var magicCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        magicCollectionView.dataSource = self
        magicCollectionView.delegate = self
        APIClient.getMagic { (appError, magic) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let magic = magic {
                self.cards = magic
            }
        }
        
    }


}
extension MagicViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicCollectionView.dequeueReusableCell(withReuseIdentifier: "MagicCollectionViewCell", for: indexPath) as? MagicCollectionViewCell else { return UICollectionViewCell()}
     let cardToSet = cards[indexPath.row]
        let url = cardToSet.imageUrl
        ImageHelper.shared.fetchImage(urlString: url!) { (error, image) in
            if let error = error {
                print(error.errorMessage())
            } else if let image = image {
                cell.magicImageView.image = image
            }
        }
        return cell
    }
}


extension MagicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc =
            storyBoard.instantiateViewController(withIdentifier: "MagicCards") as! MagicDetailViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        
        let magicCards = cards[indexPath.row]
        vc.magic = magicCards
        //shows you the viewcontroller
        present(vc, animated: true, completion: nil)
    }
    
}

