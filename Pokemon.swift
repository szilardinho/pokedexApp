//
//  Pokemon.swift
//  pokedexApp
//
//  Created by Szi Gabor on 4/23/17.
//  Copyright © 2017 Szi. All rights reserved.
//

import Foundation


class Pokemon {
    
    private var _name: String!
    private var _pokemonID: Int!
    
    
    var name: String {
        
        return _name
    }
    
    var pokemonID: Int {
     
        return _pokemonID
    }
    
    init(name: String, pokemonID: Int){
        
        self._name = name
        self._pokemonID = pokemonID
        
        
    }
    
    
    
    
    
    
    
    
}
