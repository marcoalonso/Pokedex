//
//  CeldaPokemonTableViewCell.swift
//  Pokedex
//
//  Created by marco rodriguez on 13/06/22.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var defensaPokemon: UILabel!
    @IBOutlet weak var ataquePokemon: UILabel!
    @IBOutlet weak var nombrePokemon: UILabel!
    @IBOutlet weak var imagenPokemon: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagenPokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
