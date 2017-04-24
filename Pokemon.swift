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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var  _nextEvolutionText: String!

    
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
