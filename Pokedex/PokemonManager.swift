//
//  PokemonManager.swift
//  Pokedex
//
//  Created by marco rodriguez on 13/06/22.
//

import Foundation

protocol pokemonManagerDelegado {
    func mostrarListaPokemon(lista: [Pokemon])
}

struct PokemonManager {
    var delegado: pokemonManagerDelegado?
    
    func verPokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { datos, respuesta, error in
                if error != nil {
                    print("Error al obtener datos de la API: ",error?.localizedDescription)
                }
                
                if let datosSeguros = datos?.parseData(quitarString: "null,"){
                    if let listaPokemon = self.parsearJSON(datosPokemon: datosSeguros){
                        print("Lista pokemon: ", listaPokemon)
                        
                        delegado?.mostrarListaPokemon(lista: listaPokemon)
                    }
                }
            }
            
            tarea.resume()
        }
    }
    
    func parsearJSON(datosPokemon: Data) -> [Pokemon]? {
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados = try decodificador.decode([Pokemon].self, from: datosPokemon)
            
            return datosDecodificados
            
        }catch {
            print("Error al decodificar los datos: ", error.localizedDescription)
            return nil
        }
    }
}


extension Data {
    func parseData(quitarString palabra: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
