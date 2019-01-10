//
//  MagicViewController.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {

    @IBOutlet weak var magicCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getMagic { (appError, magic) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let magic = magic {
                dump(magic)
            }
        }
        
    }


}
