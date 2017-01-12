//
//  Paquet.swift
//  TP2Swift
//
//  Created by sofiane ouafir on 01/10/16.
//  Copyright © 2016 sofiane ouafir. All rights reserved.
//

import Foundation

class Paquet{
    var cartes : [Carte]
    
    init(){
        
        cartes = [Carte]()
    }
    
    func nombre()->Int
    {
        return cartes.count
    }
    
    func estVide()->Bool
    {
        if(self.nombre() == 0)
        {
            return true
        }
        
        return false
    }
    
    func dessus()->Carte?
    {
        return cartes.last
    }
    
    func description()->String
    {
        var chaine = ""
        for c in cartes{
            chaine.stringByAppendingString("\(c.description())")
        }
        return chaine
    }
    
    func ajouteDessus(c:Carte)->Int
    {
        cartes.append(c)
        return self.nombre()
        
    }
    
    func enleveDessus()->Carte?
    {
        let carteTemp = cartes.last
        cartes.removeLast()
        return carteTemp
    }
    
    func ajouteDessous(lesCartes:[Carte])->Int
    {
        for c in lesCartes
        {
            cartes.insert(c, atIndex: 0)
        }
        
        return self.nombre()
    }
    
    func melange()
    {
        var carte : Carte
        var rand : Int
        if(nombre() >= 2)
        {
            for i in 1...99
            {
                carte = self.enleveDessus()!
                rand = Int(arc4random_uniform(100)) % nombre()
                cartes.insert(carte, atIndex: rand)
            }
        }
        
        
    }
    
    static func jeu52Cartes()->Paquet
    {
        let c1 = Carte(uneValeur: 2, uneCouleur: 0)
        let c2 = Carte(uneValeur: 14, uneCouleur: 3)
        var paquet = Paquet()
        paquet.cartes = c1...c2
        return paquet
        
    }
    
    subscript(index:Int)->Carte?
    {
        get{
            return cartes[index]
        }
    }
    
    
    
    
}