//
//  word.swift
//  WORDS
//
//  Created by Petro GOLISHEVSKIY on 11.07.2020.
//  Copyright © 2020 Petro GOLISHEVSKIY. All rights reserved.
//

import RealmSwift

class Word: Object {
    
    @objc dynamic var word: String = ""
    @objc dynamic var translate: String = ""

}
