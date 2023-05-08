//
//  ViewController.swift
//  Milestone I.2
//
//  Created by Maks Vogtman on 20/07/2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                countries.append(item)
            }
        }
        countries.sort()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].replacingOccurrences(of: "@3x.png", with: "").uppercased()
        cell.textLabel?.font = .systemFont(ofSize: 26, weight: .bold)
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

