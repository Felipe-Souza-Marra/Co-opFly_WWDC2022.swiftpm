//
//  FontsCustom.swift
//  
//
//  Created by Felipe Souza Marra on 09/04/22.
//

import Foundation
import UIKit

public struct FontsCustom {
    
    public static let font1: String = {
        let pathFont = "TopSecretStamp"
        let fontURL = Bundle.main.url(forResource: pathFont, withExtension: "ttf")
        guard let fontURL = fontURL else { fatalError("Deu ruim na url") }
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
        return "TopSecretStamp"
    }()
    
}
