//
//  Service.swift
//  PokedexApp
//
//  Created by Doğan Ensar Papuçcuoğlu on 13.10.2024.
//

import UIKit

class Service {
    
    static let shared = Service()
    
    let BASE_URL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    
    func fetchPokemon(completion: @escaping ([Pokemon]) -> (Void)) {
        
        var pokemonArray = [Pokemon]()
        
        guard let url = URL(string: BASE_URL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // handle error
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            do {
                guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else {
                    return
                }
                for (key, result) in resultArray.enumerated() {
                    if let dictionary = result as? [String: AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        guard let imageUrl = pokemon.imageUrl else {
                            return
                        }
                        
                        self.fetchImage(with: imageUrl) { image in
                            pokemon.image = image
                            pokemonArray.append(pokemon)
                            pokemonArray.sort(by: { (poke1, poke2)-> Bool in
                                return poke1.id! < poke2.id!
                            })
                            
                            completion(pokemonArray)
                            
                        }
                        
                    }
                    
                }
                
            } catch let error {
                print("Failed to create json with error: ", error.localizedDescription)
            }
        }.resume()
        
    }
    
    private func fetchImage(with string: String, completion: @escaping (UIImage) -> (Void)) {
        guard let url = URL(string: string) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch image with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            completion(image)
        }.resume()
        
        
    }
    
}
