//
//  Joueur.swift
//  TP2Swift
//
//  Created by sofiane ouafir on 02/10/16.
//  Copyright © 2016 sofiane ouafir. All rights reserved.
//

import Foundation

class Joueur : Paquet
{
    var nom : String
    var score : Dictionary<String,Int>
    var jouer : Dictionary<String,Int>
    init(UnNom:String){
        score = ["Parties gagnées avec 0 as" : 0, "Parties gagnées avec 1 as" : 0, "Parties gagnées avec 2 as" : 0
        , "Parties gagnées avec 3 as" : 0, "Parties gagnées avec 4 as" : 0]
        
        jouer = ["Parties jouées avec 0 as" : 0, "Parties jouées avec 1 as" : 0, "Parties jouées avec 2 as" : 0
            , "Parties jouées avec 3 as" : 0, "Parties jouées avec 4 as" : 0]
        self.nom = UnNom
        super.init()
    }
    
    func nombreAs()->Int
    {
        var i = 0
        for c in cartes{
            if(c.valeur.rawValue == 14)
            {
                i = i + 1
            }
        }
        
        return i
    }
    
    func numberOfWin() -> Int
    {
        var compteur = 0
        compteur = score["Parties gagnées avec 0 as"]! + score["Parties gagnées avec 1 as"]! + score["Parties gagnées avec 2 as"]! + score["Parties gagnées avec 3 as"]! + score["Parties gagnées avec 4 as"]!
        
        return compteur
    }
    
    
}