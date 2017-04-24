//
//  PokemonDetailsViewController.swift
//  pokedexApp
//
//  Created by Szi Gabor on 4/23/17.
//  Copyright © 2017 Szi. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    
    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalized
        
        let image = UIImage(named: "\(pokemon.pokemonID)")
        mainImage.image = image
        currentEvoImage.image = image
        
        pokedexLabel.text = "\(pokemon.pokemonID)"
        
        pokemon.downloadPokemonDetails {
            // whatever we write here will only call once the network call is completed
            self.updateUI()
            
        }
    }
    
    func updateUI() {
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionID == "" {
            
            evoLabel.text = "No Evolutions"
            evoLabel.isHidden = true
        } else {
            
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionID)
            let string = "Next Evolution: \(pokemon.nexEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evoLabel.text = string 
            
        }
        
    }

    @IBAction func backButtonPressde(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

}
