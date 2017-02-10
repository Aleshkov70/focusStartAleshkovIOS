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
    var date: String!
    var titles: String!
    var type: String!
    var content: String?
    var source: String?
    var network: String?
    var count = 0
    
    var imageView: UIImage?

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let textCell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        let socialCell = tableView.dequeueReusableCell(withIdentifier: "socialCell", for: indexPath) as! SocialTableViewCell

        readJson()

        if type == "text" {
            textCell.dateLabel.text = date
            textCell.titleLabel.text = titles
            textCell.messageLabel.text = content
            return textCell
        }
        
        if type == "image" {
            imageCell.dateLabel.text = date
            imageCell.titleLabel.text = titles
            
            let url = URL(string: source!)
            
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.sync() {
                    imageCell.pictureImage.image = UIImage(data: data)
                }
            }
            task.resume()
            return imageCell
        }
        
        if type == "social" {
            socialCell.dateLabel.text = date
            socialCell.titleLabel.text = titles
            if network == "twitter" {
                socialCell.iconImage.image = #imageLiteral(resourceName: "twitter")
//                let url = URL(string: source!)
            }
            if network == "facebook" {
                socialCell.iconImage.image = #imageLiteral(resourceName: "Facebook")
//                let url = URL(string: source!)
            }
            if network == "vkontakte" {
                socialCell.iconImage.image = #imageLiteral(resourceName: "vkontakte")
//                let url = URL(string: source!)
            }
            return socialCell
        }

        return textCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.estimatedRowHeight = 44
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        readJson()
        
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "messages", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    if count == 0 {
                        count = object.count
                    } else {
                        // json is an array
                        //                    print(object)
                        readArray(array: object)
                    }
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func readArray(array: [Any]) {
        count -= 1
        print(count)
        if count != 0 {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: array[count], options: JSONSerialization.WritingOptions.prettyPrinted)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
                
                date = json?["date"] as! String!
                titles = json?["title"] as! String!
                type = json?["type"] as! String!

                if source != nil {
                    print("source is nil")
                } else {
                    source = json?["source"] as! String?
                }
                
                if network != nil {
                    print("network is nil")
                } else {
                    network = json?["network"] as! String?
                }
                
                if content != nil {
                    print("content is nil")
                } else {
                    content = json!["content"] as! String?
                }
            } catch {
                print("oops")
            }
        }
    }
}
