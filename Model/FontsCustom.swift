//
//  FontsCustom.swift
//  
//
//  Created by Felipe Souza Marra on 09/04/22.
//

import Foundation
import UIKit

/// This is where all the fonts used are stored, returning their names and confirming to see if they are in the project.
public struct FontsCustom {
    
    public static let font1: String = {
        let pathFont = "TopSecretStamp"
        let fontURL = Bundle.main.url(forResource: pathFont, withExtension: "ttf")
        guard let fontURL = fontURL else { fatalError("Deu ruim na url") }
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
        return "TopSecretStamp"
    }()
    
}
