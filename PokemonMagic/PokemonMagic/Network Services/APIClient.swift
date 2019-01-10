//
//  APIClient.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import Foundation

final class APIClient {
    static func getPokemon(completionHandler: @escaping(AppError?, [PokemonInfo]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks") { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                    return
            }
            if let data = data {
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completionHandler(nil, pokemon.cards)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    static func getMagic(completionHandler: @escaping(AppError?, [MagicInfo]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.magicthegathering.io/v1/cards?contains=imageUrl") { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                    return
            }
            if let data = data {
                do {
                    let magic = try JSONDecoder().decode(Magic.self, from: data)
                    let filteredMagic = magic.cards.filter{$0.imageUrl != nil}
                    
                    
                    completionHandler(nil, filteredMagic)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
