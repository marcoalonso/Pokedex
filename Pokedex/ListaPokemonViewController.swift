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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    
}

// MARK: - Tabla
extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Pikachu"
        return celda
    }
    
    
}
