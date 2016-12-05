//
//  AppDelegate.swift
//  TP3
//
//  Created by sofiane ouafir on 10/10/16.
//  Copyright © 2016 sofiane ouafir. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    //boolean permettant de savoir si on est en mode finale ou non
    var final = false
    var paquet = Paquet()
    var argentDepart = 1000
    var partiejouees = 1
    var mise = 100
    var allIn = true
    @IBOutlet weak var window: NSWindow!
    //action permettant d'augmenter sa mise
    @IBAction func ajoute(sender: NSButton) {
        if(nCaisse >= mise)
        {
            nCaisse = nCaisse - mise
            nPari = nPari + mise
        }
        else if(nCaisse > 0 && nCaisse < mise){
            nPari = nPari + nCaisse
            nCaisse = 0
        }
        affichageGain.stringValue = ""
    }
    //bouton permettant d'enlever sa mise
    @IBAction func enleve(sender: NSButton) {
        if(nPari >= mise)
        {
            nPari = nPari - mise
            nCaisse = nCaisse + mise
        }
        else if(nPari > 0 && nPari < mise){
            nCaisse = nPari + nCaisse
            nPari = 0
        }
    }
    
    //action permettant de faire un tapis
    @IBAction func allIn(sender: NSButton) {
        if(allIn == false)
        {
            nCaisse = nCaisse + nPari
            nPari = 0
            btallIn.title = "All-in"
            allIn = true
        }
        else
        {
            nPari = nCaisse + nPari
            nCaisse = 0
            btallIn.title = "Annuler"
            allIn = false
        }
    }
    

    @IBOutlet weak var btallIn: NSButton!
    @IBOutlet weak var nbTour: NSTextField!
    @IBOutlet weak var affichageGain: NSTextField!
    @IBOutlet weak var score: NSTextField!
    @IBOutlet weak var valCaisse: NSTextField!
    @IBOutlet weak var valPari: NSTextField!
    @IBOutlet weak var carte1: CarteView!
    @IBOutlet weak var carte2: CarteView!
    @IBOutlet weak var carte3: CarteView!
    @IBOutlet weak var carte4: CarteView!
    @IBOutlet weak var carte5: CarteView!
    //nous mettons toute nos carte view dans un array pour facilité le traitement dans les differentes fonctions
    var cartesView = [CarteView]()
    var cartes = [Carte]()
    //boolean qui change a true quand le bouton est pressé en mode Finale, au prochain clique on appelle alors melangeEtDistribue()
    var rejouer = false
    

    @IBOutlet weak var btjouer: NSButton!
    @IBOutlet weak var btAjouter: NSButton!
    @IBOutlet weak var btEnlever: NSButton!
    //Accesseur
    var nCaisse : Int
    {
        get
        {
            return Int(valCaisse.stringValue)!
        }
        set
        {
            valCaisse.stringValue = String(newValue)
        }
    }
    var nPari : Int
        {
        get
        {
            return Int(valPari.stringValue)!
        }
        set
        {
            valPari.stringValue = String(newValue)
        }
        
    }
    
    // fonction permettant de gérer l'action à faire pour les differentes étapes du jeu.
    @IBAction func joue(sender: NSButton) {
        //si un pari est effectué
        if(nPari != 0)
        {
            btallIn.enabled = false
            btallIn.title = "All-in"
            allIn = true
            // si l'on est pas en mode final
            if(!final)
            {
                for carte in cartesView
                {
                    carte.estGelee = false
                    carte.estAffichee = true
                }
                btAjouter.enabled = false
                btEnlever.enabled = false
                final = true
                btjouer.title = "Finale"

            }
            else
            {
                // si on est en mode finale mais que le boolean rejouer n'est pas à true on va pouvoir
                // afficher le score (paire, double paire...), les gains gagné ou perdu...
                if(!rejouer)
                {
                    cartes = []
                    for c in cartesView
                    {
                        if(!c.estAffichee)
                        {
                            cartes.append(c.carte)
                            c.carte = paquet.enleveDessus()!
                        }
                        c.estAffichee = true
                        c.estGelee = true
                    }
                    
                    if(isFlush(cartesView))
                    {
                        if(suite(cartesView))
                        {
                            if(isRoyal(cartesView))
                            {
                                score.stringValue = "Quinte Flush Royal"
                                nCaisse = nCaisse + nPari * 250
                                affichageGain.stringValue = "Vous gagnez \(nCaisse) euros"
                            }
                            else
                            {
                                score.stringValue = "Quinte Flush"
                                nCaisse = nCaisse + nPari * 50
                                affichageGain.stringValue = "Vous gagnez \(nCaisse) euros"
                            }
                        }
                        else
                        {
                            score.stringValue = "Flush"
                            nCaisse = nCaisse + nPari * 6
                            affichageGain.stringValue = "Vous gagnez \(nCaisse) euros"
                        }
                        
                    }
                    else if(memeValeur(cartesView) != 0 && memeValeur(cartesView) != 1)
                    {
                        switch(memeValeur(cartesView))
                        {
                        case 2:
                            score.stringValue = "Double Paire"
                            nCaisse = nCaisse + nPari * 2
                            affichageGain.stringValue = "Vous gagnez \(nPari * 2) euros"
                        case 3:
                            score.stringValue = "Brelan"
                            nCaisse = nCaisse + nPari * 3
                            affichageGain.stringValue = "Vous gagnez \(nPari * 3) euros"
                        case 4:
                            score.stringValue = "Full House"
                            nCaisse = nCaisse + nPari * 9
                            affichageGain.stringValue = "Vous gagnez \(nPari * 9) euros"
                        default:
                            score.stringValue = "Poker"
                            nCaisse = nCaisse + nPari * 20
                            affichageGain.stringValue = "Vous gagnez \(nPari * 20) euros"
                            
                        }
                    }
                    else if(pair(cartesView))
                    {
                        score.stringValue = "Paire"
                        nCaisse = nCaisse + nPari * 1
                        affichageGain.stringValue = "Vous gagnez \(nPari * 1) euros"
                    }
                    else if(suite(cartesView))
                    {
                        score.stringValue = "Suite"
                        nCaisse = nCaisse + nPari * 4
                        affichageGain.stringValue = "Vous gagnez \(nPari * 4) euros"
                    }
                    else
                    {
                        score.stringValue = "Perdu"
                        affichageGain.stringValue = "Vous perdez \(nPari) euros"
                    }
               
                    for c in cartesView
                    {
                        cartes.append(c.carte)
                    }
                    paquet.ajouteDessous(cartes)
                    rejouer = true
                    if(nCaisse == 0)
                    {
                        sender.title = "Nouvelle partie"
                    }
                    else
                    {
                        sender.title = "Play again ?"
                    }
                }
                // si le boolean rejouer est a true on appelle la fonction melangeEtDistribue()
                else
                {
                    // avant d'appeler melangeEtDistribue() on verifie qu'il reste des sous dans la caisse, si ce n'est 
                    // pas le cas, on en redonne est on incremente partiejouees.
                    if(nCaisse == 0)
                    {
                        nCaisse = argentDepart
                        partiejouees = partiejouees + 1
                        nbTour.stringValue = "Partie jouées : \(partiejouees)"
                    }
                    melangeEtDistribue()
                }
            }
        }
        else
        {
            affichageGain.stringValue = "Pariez avant de jouer !"
        }
    }
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        nCaisse = argentDepart
        nbTour.stringValue = "Partie jouées : \(partiejouees)"
        nPari = 0
        btallIn.title = "All-in"
        paquet = Paquet.jeu52Cartes()
        cartesView.append(carte1)
        cartesView.append(carte2)
        cartesView.append(carte3)
        cartesView.append(carte4)
        cartesView.append(carte5)
        valCaisse.enabled = false
        valPari.enabled = false
        melangeEtDistribue()

        

       
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func melangeEtDistribue()
    {
        btallIn.enabled = true
        nPari = 0
        btjouer.title = "Play !"
        score.stringValue = ""
        affichageGain.stringValue = ""
        btAjouter.enabled = true
        btEnlever.enabled = true
        paquet.melange()
        final = false
        rejouer = false
        
        for c in cartesView
        {
            c.estAffichee = false
            c.estGelee = true
            c.carte = paquet.enleveDessus()!
        }
        
        //Tester le full house
//        cartesView[0].carte = Carte(uneValeur: 5, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 5, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 5, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 14, uneCouleur: 1)
//        cartesView[4].carte = Carte(uneValeur: 14, uneCouleur: 0)
        
        
        //tester poker
//        cartesView[0].carte = Carte(uneValeur: 5, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 5, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 5, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 5, uneCouleur: 3)
//        cartesView[4].carte = Carte(uneValeur: 14, uneCouleur: 0)
        
        //tester suite
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 2, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 3, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 4, uneCouleur: 1)
//        cartesView[4].carte = Carte(uneValeur: 5, uneCouleur: 0)
        
//        //tester brelan
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 14, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 14, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 4, uneCouleur: 1)
//        cartesView[4].carte = Carte(uneValeur: 5, uneCouleur: 0)
//
//        //tester double paire
//        
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 14, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 3, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 3, uneCouleur: 1)
//        cartesView[4].carte = Carte(uneValeur: 5, uneCouleur: 0)
//
//        //tester paire
//        
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 14, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 3, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 4, uneCouleur: 1)
//        cartesView[4].carte = Carte(uneValeur: 5, uneCouleur: 0)
//
//        //tester perdu
//        
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 2, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 3, uneCouleur: 2)
//        cartesView[3].carte = Carte(uneValeur: 4, uneCouleur: 1)
//       cartesView[4].carte = Carte(uneValeur: 4, uneCouleur: 0)
//        
//        //tester flush
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 1)
//        cartesView[1].carte = Carte(uneValeur: 3, uneCouleur: 1)
//        cartesView[2].carte = Carte(uneValeur: 6, uneCouleur: 1)
//        cartesView[3].carte = Carte(uneValeur: 4, uneCouleur: 1)
//        cartesView[4].carte = Carte(uneValeur: 5, uneCouleur: 1)
//
//        //tester quinte flush
//        cartesView[0].carte = Carte(uneValeur: 14, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 2, uneCouleur: 0)
//        cartesView[2].carte = Carte(uneValeur: 3, uneCouleur: 0)
//        cartesView[3].carte = Carte(uneValeur: 4, uneCouleur: 0)
//        cartesView[4].carte = Carte(uneValeur: 5, uneCouleur: 0)
//        
//        //tester quinte flush royale
//        
//        cartesView[0].carte = Carte(uneValeur: 10, uneCouleur: 0)
//        cartesView[1].carte = Carte(uneValeur: 11, uneCouleur: 0)
//        cartesView[2].carte = Carte(uneValeur: 12, uneCouleur: 0)
//        cartesView[3].carte = Carte(uneValeur: 13, uneCouleur: 0)
//        cartesView[4].carte = Carte(uneValeur: 14, uneCouleur: 0)
        
    }
    
    // fonction qui vérifie si il y a une paire
    func pair(liste:[CarteView])->Bool
    {
        var d = 0
        var i = 0
        var compteur = 0
        for c in liste
        {
            i = i + 1
            d = i
            while(d <= liste.count - 1)
            {
                if(c.carte.valeur.rawValue == liste[d].carte.valeur.rawValue && c.carte.valeur.rawValue >= 11)
                {
                    compteur = compteur + 1
                }
                d = d + 1
            }
        }
        
        if(compteur == 1)
        {
            return true
        }
        
        return false
        
    }
    
    //fonction qui compare les carte entre elle: si la valeur de retour est 2 -> double paire, 3 -> brelan, 4 -> poker, 6 -> full house
    func memeValeur(liste:[CarteView])->Int
    {
        var d = 0
        var i = 0
        var compteur = 0
        for c in liste
        {
            i = i + 1
            d = i
            while(d <= liste.count - 1)
            {
                if(c.carte.valeur.rawValue == liste[d].carte.valeur.rawValue)
                {
                    compteur = compteur + 1
                }
                d = d + 1
            }
        }
        
        return compteur
    }
    
    //fonction qui verifie si il y a une suite
    func suite(liste:[CarteView])->Bool
    {
        var j = 0
        var tableauValeur = tableauOrdreCroissant(liste)
        if(!isSuiteAsTo5(liste))
        {
            for c in tableauValeur
            {
                if(!(tableauValeur[0] - c == j))
                {
                    return false
                }
                j = j - 1
            }
            
            return true
        }
        else
        {
            return true
        }
        
    }
    
    //fonction qui verifie s'il il y a une suite allant de AS à 5
    func isSuiteAsTo5(liste:[CarteView])->Bool
    {
        var tableauValeur = tableauOrdreCroissant(liste)
       
        if(tableauValeur[0] == 2 && tableauValeur[1] == 3 && tableauValeur[2] == 4 && tableauValeur[3] == 5 && tableauValeur[4] == 14)
        {
            return true
        }
        
        return false
    }
    
    //fonction qui verifie si il y a une couleur
    func isFlush(liste:[CarteView]) -> Bool
    {
        let color = liste[0].carte.couleur.rawValue
        for c in liste
        {
            if(c.carte.couleur.rawValue != color)
            {
                return false
            }
        }
        
        return true
    }
    
    //fonction qui verifie si la suite de carte est royale
    
    func isRoyal(liste:[CarteView]) -> Bool
    {
        var tableauValeur = tableauOrdreCroissant(liste)
        if(tableauValeur[0] == 10 && tableauValeur[1] == 11 && tableauValeur[2] == 12 && tableauValeur[3] == 13 && tableauValeur[4] == 14)
        {
            return true
        }
        
        return false
    }
    
    // fonction qui depuis la liste de carte retourne un tableau de int en ordre croissant
    func tableauOrdreCroissant(liste:[CarteView]) -> [Int]
    {
        var temp = 0
        var i = 0
        var j = 0
        
        var tableauValeur : [Int] = []
        
        for c in liste
        {
            tableauValeur.append(c.carte.valeur.rawValue)
        }
        
        while(i <= tableauValeur.count - 1)
        {
            j = i + 1
            while(j <= tableauValeur.count - 1)
            {
                if(tableauValeur[i] > tableauValeur[j])
                {
                    temp = tableauValeur[i]
                    tableauValeur[i] = tableauValeur[j]
                    tableauValeur[j] = temp
                }
                j = j + 1
            }
            i = i + 1
        }
        
        return tableauValeur
    }

    


}

