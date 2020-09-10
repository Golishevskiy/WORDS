//
//  ViewController.swift
//  WORDS
//
//  Created by Petro GOLISHEVSKIY on 10.07.2020.
//  Copyright © 2020 Petro GOLISHEVSKIY. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

protocol WordDelegate {
    func passWordBack(word: Word)
}

class WordList: UIViewController, WordDelegate {
    
    private let strawbery = UIColor(red: 1, green: 0.15, blue: 0.5, alpha: 1)
    var arrayWords = [Word].init()
    @IBOutlet weak var wordsTableView: UITableView!
    var newWord: Word?
    let userNotificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        print(Realm.Configuration.defaultConfiguration.description)

        super.viewDidLoad()
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
        self.sendNotification()
        self.title = "Words"
    }
    
    func passWordBack(word: Word) {
        arrayWords.append(word)
        wordsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        wordsTableView.reloadData()
        
        
        print(#function)
        

    }
        
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }

    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "Test"
        notificationContent.body = "Test body"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default

        // Add an attachment to the notification content
//        if let url = Bundle.main.url(forResource: "dune",
//                                        withExtension: "png") {
//            if let attachment = try? UNNotificationAttachment(identifier: "dune",
//                                                                url: url,
//                                                                options: nil) {
//                notificationContent.attachments = [attachment]
//            }
//        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
        repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification",
        content: notificationContent,
        trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
   
    
    
    
    @IBAction func ref(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        guard let info = realm.objects(Word.self).first else { return }
        let name = info.word.description
        let gender = info.translate.description
        print("\(name) + \(gender)")
    }
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "AddWord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddWordID") as! AddWord
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension WordList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wordsTableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        cell.textLabel?.text = "\(arrayWords[indexPath.row].word) -> \(arrayWords[indexPath.row].translate)"
        return cell
    }
}

extension WordList: UITableViewDelegate {
    
}

extension WordList: UNUserNotificationCenterDelegate {
    
}

