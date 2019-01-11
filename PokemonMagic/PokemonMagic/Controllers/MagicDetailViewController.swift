//
//  MagicDetailViewController.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit

class MagicDetailViewController: UIViewController {
    var magic: MagicInfo!
    
    var cards = [ForeignInfo]()
    @IBOutlet weak var magicDetailCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        magicDetailCollectionView.dataSource = self
        cards = magic.foreignNames
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension MagicDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "MagicDetailCollectionViewCell", for: indexPath) as? MagicDetailCollectionViewCell else { return UICollectionViewCell()}
        let cardToSet = cards[indexPath.row]
        let url = cardToSet.imageUrl
        ImageHelper.shared.fetchImage(urlString: url) { (error, image) in
            if let error = error {
                print(error.errorMessage())
            } else if let image = image {
                cell.magicImage?.image = image
            }
        }
        cell.languageLabel?.text = cardToSet.language
        cell.magicText?.text = cardToSet.text
        cell.nameLabel?.text = cardToSet.name
        return cell
    }
}


