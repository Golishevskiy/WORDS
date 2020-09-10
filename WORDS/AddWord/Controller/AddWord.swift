//
//  AddWord.swift
//  WORDS
//
//  Created by Petro GOLISHEVSKIY on 10.07.2020.
//  Copyright © 2020 Petro GOLISHEVSKIY. All rights reserved.
//

import UIKit
import RealmSwift

class AddWord: UIViewController {
        
    var delegate: WordDelegate?
    var wordArray = [Word]()
    private let strawbery = UIColor(red: 1, green: 0.15, blue: 0.5, alpha: 1)
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var transliteTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        navBar.title = "New word"
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = strawbery
        UINavigationBar.appearance().tintColor = .white
        setUpButton()
    }
    
    
    func setUpButton() {
        saveButton.backgroundColor = strawbery
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitleColor(.green, for: .selected)
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowRadius = 5
        saveButton.layer.shadowOpacity = 0.4
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 6)
    }
    
    @IBAction func wordTextFieldAction(_ sender: UITextField) {
    }
    
    @IBAction func transliteTextFieldAction(_ sender: UITextField) {
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let newWord = Word()
        newWord.word = wordTextField.text!
        newWord.translate = transliteTextField.text!
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(newWord)
        }
//
//        self.delegate?.passWordBack(word: newWord)
        dismiss(animated: true, completion: nil)
    }
}
