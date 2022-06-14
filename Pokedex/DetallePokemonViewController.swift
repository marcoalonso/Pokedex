//
//  DetallePokemonViewController.swift
//  Pokedex
//
//  Created by marco rodriguez on 13/06/22.
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    // MARK: - Variables
    var pokemonMostrar: Pokemon?
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var defensaPokemon: UILabel!
    @IBOutlet weak var ataquePokemon: UILabel!
    @IBOutlet weak var tipoPokemon: UILabel!
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var descripcionPokemon: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Imagen mostrar
        imagenPokemon.loadFrom(URLAddres: pokemonMostrar?.imageUrl ?? "")
        tipoPokemon.text = "Tipo : \(pokemonMostrar?.type ?? "")"
        ataquePokemon.text = "Ataque: \(pokemonMostrar!.attack)"
        defensaPokemon.text = "Defensa: \(pokemonMostrar!.defense)"
        descripcionPokemon.text = pokemonMostrar?.description ?? ""
        
    }
}


extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imagenData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
