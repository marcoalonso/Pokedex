//
//  ViewController.swift
//  Pokedex
//
//  Created by marco rodriguez on 13/06/22.
//

import UIKit

class ListaPokemonViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    @IBOutlet weak var tablaPokemon: UITableView!
    
    // MARK: - Variables
    var pokemonManager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    
    var pekemonSeleccionado: Pokemon?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registrar nueva celda
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        pokemonManager.delegado = self
        
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        //Ejecutar el metodo para buscar la lista de pokemon
        pokemonManager.verPokemon()
    }
}

// MARK: - Delegado Pokemon
extension ListaPokemonViewController: pokemonManagerDelegado {
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async {
            self.tablaPokemon.reloadData()
        }
    }
    
    
}

// MARK: - Tabla
extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.nombrePokemon.text = pokemons[indexPath.row].name
        celda.ataquePokemon.text = "Ataque: \(pokemons[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(pokemons[indexPath.row].defense)"
        
        
        //celda imagen desde URL
        if let urlString = pokemons[indexPath.row].imageUrl as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else { return }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPokemon.image = image
                    }
                }
            }
        }
        
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pekemonSeleccionado = pokemons[indexPath.row]
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
        //Deseleccionar
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon" {
            let verPokemon = segue.destination as! DetallePokemonViewController
            verPokemon.pokemonMostrar = pekemonSeleccionado
        }
    }
    
}
