//
//  Pokemon.swift
//  pokedexApp
//
//  Created by Szi Gabor on 4/23/17.
//  Copyright © 2017 Szi. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    
    private var _name: String!
    private var _pokemonID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }

    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }

    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText : String {
        
        if _nextEvolutionText == nil {
            
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var name: String {
        
        return _name
    }
    
    var pokemonID: Int {
     
        return _pokemonID
    }
    
    init(name: String, pokemonID: Int){
        
        self._name = name
        self._pokemonID = pokemonID
        
        self._pokemonURL = "\(URL_base)\(URL_pokemon)\(self.pokemonID)/"
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
           if let dictionary = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dictionary["weight"] as? String {
                    
                    self._weight = weight
                }
            
            if let height = dictionary["height"] as? String {
                
                    self._height = height
            }
            
            if let attack = dictionary["attack"] as? Int {
                
                    self._attack = "\(attack)"
            }
            
            if let defense = dictionary["defense"] as? Int {
                
                    self._defense = "\(defense)"
            }
            
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
            }
            
            completed()
            
        }
        
    }
    
    
    
    
    
    
    
    
}
