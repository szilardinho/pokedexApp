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
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }

    
    var nextEvolutionID: String {
        
        if _nextEvolutionID == nil {
            
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }

    
    var nexEvolutionName: String {
        
        if _nextEvolutionName == nil {
            
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }

    
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
            
            if let types = dictionary["types"] as? [Dictionary<String, String>] , types.count > 0 {
                
                
                if let name = types[0]["name"]  {
                    
                    self._type = name.capitalized
                }
                
                if types.count > 1 {
                    
                    for x in 1..<types.count {
                        
                        if let name = types[x]["name"] {
                            
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                }
                
                print(self._type)
                
            } else {
                
                    self._type = ""
            }
            
            
            if let descriptionArray = dictionary["descriptions"] as? [Dictionary<String, String>] , descriptionArray.count > 0 {
                
                if let url = descriptionArray[0]["resource_uri"] {
                    
                    let descriptionURL = "\(URL_base)\(url)"
                    
                    Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                        
                        if let descriptionDictionary = response.result.value as? Dictionary<String, AnyObject> {
                            
                            if let description = descriptionDictionary["description"] as? String {
                                
                                let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokèmon")
                                
                                self._description = newDescription
                                
                                print(newDescription)
                            }
                        }
                        
                        completed()
                        
                        
                        
                    })
                }
                
                
            } else {
                
                self._description = ""
            }
            
            if let evolutions = dictionary["evolutions"] as?  [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                
                if let nextEvo = evolutions[0]["to"] as? String {
                    
                    if nextEvo.range(of: "mega") == nil {
                        
                        self._nextEvolutionName = nextEvo
                        
                        if let uri = evolutions[0]["resource_uri"] as? String {
                            
                            let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let nextEvoID =  newString.replacingOccurrences(of: "/", with: "")
                            
                            self._nextEvolutionID = nextEvoID
                            
                            if let levelExist = evolutions[0]["level"] {
                                
                                if let level  = levelExist as? Int {
                                    
                                    self._nextEvolutionLevel = "\(level)"
                                }
                            } else {
                                
                                self._nextEvolutionLevel = ""
                                }
                            
                            }
                        
                        }
                    
                    }
                
                    print(self._nextEvolutionID)
                    print(self._nextEvolutionLevel)
                    print(self._nextEvolutionName)
                
                }
            
            }
            
            completed()
            
        }
        
    }
    
    
}
