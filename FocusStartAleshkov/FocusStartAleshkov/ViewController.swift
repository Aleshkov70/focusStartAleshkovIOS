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

    @IBOutlet weak var mainTableView: UITableView!
    var arrayOfDictionary: [[String : Any]] = []
    var photoArray: [Any] = []
    var iconArray: [Any] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDictionary.count
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayOfDictionary.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.dateLabel.text = arrayOfDictionary[indexPath.row]["date"] as! String?
        cell.titleLabel.text = arrayOfDictionary[indexPath.row]["title"] as! String?
        cell.messageLabel.text = arrayOfDictionary[indexPath.row]["content"] as! String?
        cell.downloadImage.image = photoArray[indexPath.row] as? UIImage
        cell.labelImage.image = iconArray[indexPath.row] as? UIImage
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.estimatedRowHeight = 80
        mainTableView.rowHeight = UITableViewAutomaticDimension
        readFileJson()
        sortArray()
        photoArray = downloadImage(photoArray)
        iconArray = setIcon(iconArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sortArray() {
        var sortedArray: [[String : Any]] = arrayOfDictionary
        
        for i in 0 ..< sortedArray.count {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var dic: [String : Any] = sortedArray[i]
            let date = dateFormatter.date(from: dic["date"] as! String!)
            sortedArray[i].updateValue(date ?? "", forKey: "date")
        }
        
        sortedArray = insertionSort(sortedArray)
        
        for i in 0 ..< sortedArray.count {
            let dateFormatter = DateFormatter()
            var dic: [String : Any] = sortedArray[i]
            let date = dic["date"] as! Date
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let newDate = dateFormatter.string(from: date)
            sortedArray[i].updateValue(newDate, forKey: "date")
        }
        arrayOfDictionary = sortedArray
    }
    
    func insertionSort(_ array: [[String : Any]]) -> [[String : Any]] {
        
        var sortedArray = array
        for i in 1 ..< sortedArray.count {
            var y = i
            while y > 0 && (sortedArray[y]["date"] as! Date) > (sortedArray[y-1]["date"] as! Date) {
                swap(&sortedArray[y-1], &sortedArray[y])
                y -= 1
            }
        }
        return sortedArray
    }
    
    private func setIcon(_ array: [Any]) -> [Any] {
        var icon: [Any] = array
        for i in 0 ..< arrayOfDictionary.count {
            icon.append(i)
            if arrayOfDictionary[i]["type"] as? String == "social" {
                switch arrayOfDictionary[i]["network"] as! String {
                case "vkontakte":
                    icon[i] = #imageLiteral(resourceName: "vkontakte")
                case "facebook":
                    icon[i] = #imageLiteral(resourceName: "Facebook")
                case "twitter":
                    icon[i] = #imageLiteral(resourceName: "twitter")
                default:
                    break
                }
            } else {
                icon[i] = UIImage()
            }
        }
        iconArray = icon
        return icon
    }
    
    private func downloadImage(_ array: [Any]) -> [Any] {
        var photo: [Any] = array
        for i in 0 ..< arrayOfDictionary.count {
            photo.append(i)
            if arrayOfDictionary[i]["source"] as? String != nil && arrayOfDictionary[i]["type"] as? String == "image" {
                let url = URL(string: arrayOfDictionary[i]["source"] as! String)
                let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.sync() {
                        photo[i] = UIImage(data: data)!
                        self.photoArray = photo
                    }
                }
                task.resume()
            } else {
                photo[i] = UIImage()
            }
        }
        return photo
    }
    
    private func readFileJson() {
        do {
            if let file = Bundle.main.url(forResource: "messages", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [[String : Any]] {
                    arrayOfDictionary = object
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
