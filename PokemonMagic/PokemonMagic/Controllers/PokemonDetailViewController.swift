//
//  PokemonDetailViewController.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: PokemonInfo!
    private var attacks = [Attack]()

    @IBOutlet weak var highresImage: UIImageView!
    @IBOutlet weak var pokemonDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePokemonImage()
        pokemonDetailCollectionView.dataSource = self
        pokemonDetailCollectionView.delegate = self
        attacks = pokemon.attacks
        print(attacks)
    }
    private func updatePokemonImage() {
        DispatchQueue.main.async {
            let url = self.pokemon.imageUrlHiRes
            ImageHelper.shared.fetchImage(urlString: url, completionHandler: { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.highresImage.image = image
                }
            })
        }
    }
     @IBAction func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
     }

}
extension PokemonDetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attacks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonDetailCollectionViewCell", for: indexPath) as? PokemonDetailCollectionViewCell else { return UICollectionViewCell()}
        let attackToSet = attacks[indexPath.row]
        cell.attackLabel.text = attackToSet.name
        cell.hpLabel.text = attackToSet.damage
        print(attackToSet.text.isEmpty)
        if !attackToSet.text.isEmpty {
            cell.pokemonText.text = attackToSet.text
        } else {
            cell.pokemonText.isHidden = true
        }

        return cell
    }
}
extension PokemonDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 300, height: 167)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did it")
    }
}


