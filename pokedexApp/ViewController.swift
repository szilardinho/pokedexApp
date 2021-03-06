//
//  ViewController.swift
//  pokedexApp
//
//  Created by Szi Gabor on 4/21/17.
//  Copyright © 2017 Szi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon =  [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = .done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "pokemonTheme", ofType: "mp3")!

        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
            
         catch let error as NSError {
            
            print(error.debugDescription)
            
        }
        
    }



    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokemonID: pokeID)
                
                pokemon.append(poke)
            }
            
        }   catch let error as NSError {
            
            print(error.debugDescription)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            let poke: Pokemon!
            
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
                
            } else {
            
            poke = pokemon[indexPath.row]
            cell.configureCell(poke)
                
            }
            return cell
        }
        else {
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       var poke: Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
        }
        else {
            
            poke = pokemon[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            
            return filteredPokemon.count
        }
        
        
        return pokemon.count
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            
            if let detailsVC =  segue.destination as? PokemonDetailsViewController {
                if let poke = sender as? Pokemon {
                    
                    detailsVC.pokemon = poke
                }
            }
            
        }
    }
    
}

