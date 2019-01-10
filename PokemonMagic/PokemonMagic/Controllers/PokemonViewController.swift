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
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getPokemon { (appError, pokemon) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let pokemon = pokemon {
               dump(pokemon)
            }
        }
        
    }

}
