//
//  PokemonViewController.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    private var pokemonPlural = [PokemonInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.pokemonCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        fetchPokemon()
    }
    private func fetchPokemon() {
        APIClient.getPokemon { (appError, pokemon) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let pokemon = pokemon {
                self.pokemonPlural = pokemon
            }
        }
    }

}

extension PokemonViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonPlural.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else { return UICollectionViewCell()}
        let pokemon = pokemonPlural[indexPath.row]
        let url = pokemon.imageUrl
            ImageHelper.shared.fetchImage(urlString: url, completionHandler: { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    cell.PokemonImageView.image = image
                }
            })
        return cell
    }
}



extension PokemonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 175)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("it did it")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let pokemonDetailVC = storyboard.instantiateViewController(withIdentifier: "PokemonDetail") as? PokemonDetailViewController else {return}
        pokemonDetailVC.modalPresentationStyle = .overCurrentContext
        
        let pokemon = pokemonPlural[indexPath.row]
        
        pokemonDetailVC.pokemon = pokemon
        
        present(pokemonDetailVC, animated: true, completion: nil)
    }
}
