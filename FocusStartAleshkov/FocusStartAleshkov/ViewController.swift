//
//  ViewController.swift
//  FocusStartAleshkov
//
//  Created by andrey on 09.02.17.
//  Copyright © 2017 andrey. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    var array: [Any] = []
    var dict: [String: Any] = [:]
    var count: Int = -1

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if count < array.count {
            count += 1
            if count != array.count {
                makeDictionary(array: array, number: count)
                
                let textCell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
                let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
                let socialCell = tableView.dequeueReusableCell(withIdentifier: "socialCell", for: indexPath) as! SocialTableViewCell
                
                if dict["type"] as! String! == "text" {
                    textCell.titleLabel.text = dict["title"] as! String!
                    textCell.dateLabel.text = dict["date"] as! String!
                    textCell.messageLabel.text = dict["content"] as! String!
                    return textCell
                }
                
                if dict["type"] as! String == "image" {
                    imageCell.dateLabel.text = dict["date"] as! String!
                    imageCell.titleLabel.text = dict["title"] as! String!
                    
                    let url = URL(string: dict["source"] as! String!)
                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.sync() {
                            imageCell.pictureImage.image = UIImage(data: data)
                        }
                    }
                    task.resume()
                    
                    return imageCell
                }
                
                if dict["type"] as! String! == "social" {
                    socialCell.dateLabel.text = dict["date"] as! String!
                    socialCell.titleLabel.text = dict["title"] as! String!
                    if dict["network"] as! String == "twitter" {
                        socialCell.iconImage.image = #imageLiteral(resourceName: "twitter")
                        //                let url = URL(string: source!)
                    }
                    if dict["network"] as! String == "facebook" {
                        socialCell.iconImage.image = #imageLiteral(resourceName: "Facebook")
                        //                let url = URL(string: source!)
                    }
                    if dict["network"] as! String == "vkontakte" {
                        socialCell.iconImage.image = #imageLiteral(resourceName: "vkontakte")
                        //                let url = URL(string: source!)
                    }
                    return socialCell
                    
                }
            } else {
                print("out of range")
            }
        }
        fatalError("💥 Unexpected behaviour: only 3 tables are supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readJson()
        self.myTableView.estimatedRowHeight = 100
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "messages", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    array = object
//                    readArray(array: object)
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func makeDictionary(array: [Any], number: Int) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: array[number], options: JSONSerialization.WritingOptions.prettyPrinted)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                dict = json!
            } catch {
                print("oops")
            }
        }

}
