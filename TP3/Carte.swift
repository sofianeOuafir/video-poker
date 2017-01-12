//
//  Carte.swift
//  TP2Swift
//
//  Created by sofiane ouafir on 26/09/16.
//  Copyright © 2016 sofiane ouafir. All rights reserved.
//

import Foundation

enum Valeur : Int
{
    case DEUX = 2, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF, DIX, VALET, DAME, ROI, AS
}

enum Couleur : Int
{
    case TREFLE = 0
    case CARREAU = 1
    case COEUR = 2
    case PIQUE = 3
}


struct Carte{
    let couleur : Couleur
    let valeur : Valeur
    
    var carte:String
    {
        
        get {
            return "\(self.valeur) \(self.couleur)"
        }
    
    }
    
    init(uneValeur: Int, uneCouleur:Int)
    {
        var maValeur : Valeur
        var maCouleur : Couleur
        switch(uneValeur){
        case 2:
            maValeur = Valeur.DEUX
        case 3:
            maValeur = Valeur.TROIS
        case 4:
            maValeur = Valeur.QUATRE
        case 5:
            maValeur = Valeur.CINQ
        case 6:
            maValeur = Valeur.SIX
        case 6:
            maValeur = Valeur.SEPT
        case 8:
            maValeur = Valeur.HUIT
        case 9:
            maValeur = Valeur.NEUF
        case 10:
            maValeur = Valeur.DIX
        case 11:
            maValeur = Valeur.VALET
        case 12:
            maValeur = Valeur.DAME
        case 13:
            maValeur = Valeur.ROI
        case 14:
            maValeur = Valeur.AS
        default:
            maValeur = Valeur.DEUX
        }
        
        switch(uneCouleur){
        case 0:
            maCouleur = Couleur.TREFLE
        case 1:
            maCouleur = Couleur.CARREAU
        case 2:
            maCouleur = Couleur.COEUR
        case 3:
            maCouleur = Couleur.PIQUE
        default:
            maCouleur = Couleur.PIQUE
        }
        
        self.valeur = maValeur
        self.couleur = maCouleur
    }
    
    func description()->String
    {
        if(self.couleur == Couleur.TREFLE)
        {
            return "\(self.valeur)♣︎"
        }
        else if(self.couleur == Couleur.CARREAU)
        {
            return "\(self.valeur)⬥"
        }
        else if(self.couleur == Couleur.COEUR)
        {
            return "\(self.valeur)♥︎"
        }
        
        return "\(self.valeur)♠︎"
    }
    
    func isFigure() -> Bool{
        if(self.valeur.rawValue > 10)
        {
            return true;
        }
        
        return false;
    }
}

    func ==(c1: Carte, c2: Carte) -> Bool{
        if(c1.valeur.rawValue == c2.valeur.rawValue){
            return true;
        }
        
        return false;
    }

func !=(c1: Carte, c2: Carte) -> Bool{
        if(c1.valeur.rawValue != c2.valeur.rawValue)
        {
            return true;
        }
    
    return false;
}
func <(c1: Carte, c2: Carte)->Bool{
    if (c1.valeur.rawValue<c2.valeur.rawValue)
    {
        return true
    }
    return false
}
func <=(c1 : Carte, c2 :Carte)->Bool
{
    if (c1.valeur.rawValue<=c2.valeur.rawValue)
    {
        return true
    }
    return false
}

func >(c1 : Carte, c2 : Carte)->Bool{
    if(c1.valeur.rawValue > c2.valeur.rawValue)
    {
        return true
    }
    return false
}

func >=(c1: Carte, c2:Carte)->Bool{
    if (c1.valeur.rawValue>=c2.valeur.rawValue)
    {
        return true
    }
    return false
}

func <=(c1: Couleur, c2: Couleur)->Bool
{
    if(c1.rawValue <= c2.rawValue)
    {
        return true;
    }
    
    return false;
    
}

func <(c1: Couleur, c2: Couleur)->Bool
{
    if(c1.rawValue < c2.rawValue)
    {
        return true;
    }
    
    return false;
    
}

func ==(c1: Couleur, c2: Couleur)->Bool
{
    if(c1.rawValue == c2.rawValue)
    {
        return true;
    }
    
    return false;
    
}

func >=(c1: Couleur, c2: Couleur)->Bool
{
    if(c1.rawValue >= c2.rawValue)
    {
        return true;
    }
    
    return false;
    
}

func >(c1: Couleur, c2: Couleur)->Bool
{
    if(c1.rawValue > c2.rawValue)
    {
        return true;
    }
    
    return false;
    
}

func ...(c1: Carte, c2: Carte) -> Array<Carte>
{
    var arr = [Carte]()
    
    if(c1.couleur < c2.couleur)
    {
        for i in c1.couleur.rawValue...c2.couleur.rawValue
        {
            if(i == c2.couleur.rawValue)
            {
                for j in c1.valeur.rawValue...c2.valeur.rawValue
                {
                    var carte = Carte(uneValeur:j,uneCouleur:i)
                    arr.append(carte)
                }
            }
            else
            {
                for j in c1.valeur.rawValue...14
                {
                    var carte = Carte(uneValeur:j,uneCouleur:i)
                    arr.append(carte)
                }
            }
        }
        
        return arr
    }
    else if(c1.couleur == c2.couleur)
    {
        if(c1.valeur.rawValue <= c2.valeur.rawValue)
        {
            for i in c1.couleur.rawValue...c2.couleur.rawValue
            {
                if(i == c2.couleur.rawValue)
                {
                    for j in c1.valeur.rawValue...c2.valeur.rawValue
                    {
                        var carte = Carte(uneValeur:j,uneCouleur:i)
                        arr.append(carte)
                    }
                }
                else
                {
                    for j in c1.valeur.rawValue...14
                    {
                        var carte = Carte(uneValeur:j,uneCouleur:i)
                        arr.append(carte)
                    }
                }
            
            }
            return arr
        }
    }
    
    
    
    return arr
}




func ..<(c1: Carte, c2: Carte) -> Array<Carte>
{
    var arr = [Carte]()
    
    if(c1.couleur < c2.couleur)
    {
        for i in c1.couleur.rawValue...c2.couleur.rawValue
        {
            if(i == c2.couleur.rawValue)
            {
                for j in c1.valeur.rawValue...c2.valeur.rawValue - 1
                {
                    var carte = Carte(uneValeur:j,uneCouleur:i)
                    arr.append(carte)
                }
            }
            else
            {
                for j in c1.valeur.rawValue...14
                {
                    var carte = Carte(uneValeur:j,uneCouleur:i)
                    arr.append(carte)
                }
            }
        }
        
        return arr
    }
    else if(c1.couleur == c2.couleur)
    {
        if(c1.valeur.rawValue <= c2.valeur.rawValue)
        {
            for i in c1.couleur.rawValue...c2.couleur.rawValue
            {
                if(i == c2.couleur.rawValue)
                {
                    for j in c1.valeur.rawValue...c2.valeur.rawValue - 1
                    {
                        var carte = Carte(uneValeur:j,uneCouleur:i)
                        arr.append(carte)
                    }
                }
                else
                {
                    for j in c1.valeur.rawValue...14
                    {
                        var carte = Carte(uneValeur:j,uneCouleur:i)
                        arr.append(carte)
                    }
                }
                
            }
            return arr
        }
    }
    
    
    
    return arr
}













