//
//  CarteView.swift
//  TP3
//
//  Created by sofiane ouafir on 10/10/16.
//  Copyright © 2016 sofiane ouafir. All rights reserved.
//

import Cocoa

class CarteView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let imageCarte : NSImage
        var rectanglesource : NSRect
        if(!self.estAffichee)
        {
            imageCarte = NSImage(named: "dos")!
        
            rectanglesource = NSRect(x:0, y: 0, width:imageCarte.size.width, height: imageCarte.size.height)
            
            imageCarte.drawInRect(NSRect(x:0, y:0, width:self.frame.width, height:self.frame.height), fromRect: rectanglesource, operation: .CompositeSourceOver, fraction: 1)
        }
        else
        {
            imageCarte = NSImage(named: "cartes")!
            var x = (self.carte.valeur.rawValue - 2) * 150
            var y : Int
            switch(self.carte.couleur.rawValue)
            {
            case(0):
                y = 0
            case(1):
                y = 400
            case(2):
                y = 600
            case(3):
                y = 200
            default:
                y = 0
            }
            rectanglesource = NSRect(x:x, y: y, width:150, height: 200)
            
            imageCarte.drawInRect(NSRect(x:0, y:0, width:self.frame.width, height:self.frame.height), fromRect: rectanglesource, operation: .CompositeSourceOver, fraction: 1)
            
        }

    }
    
    override func mouseDown(theEvent: NSEvent) {
        if(!self.estAffichee)
        {
            if(!self.estGelee)
            {
                self.estAffichee = true
            }
        }else{
            if(!self.estGelee)
            {
                self.estAffichee = false
            }
        }
    }
        var carte = Carte(uneValeur: 2, uneCouleur: 0)
        var estAffichee = false
            {
            didSet{
                setNeedsDisplayInRect(self.bounds)
            }
    }
        var estGelee = false
        

    
    
}
