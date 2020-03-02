//
//  ViewController.swift
//  landmarkBook
//
//  Created by Mustafa IŞIK on 27.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var landmarkNames =  [String]()
    var landmarkImages =  [UIImage]()
    
    var choesenLanmarkNames = ""
    var choesenLandmarkImages = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        landmarkNames.append("Anitkabir")
        landmarkNames.append("Ulu Camii")
        landmarkNames.append("Truva Ati")
        landmarkNames.append("Saat Kulesi")
        landmarkNames.append("Agri Dagi")
        
        
        landmarkImages.append(UIImage(named: "anitkabir")!)
        landmarkImages.append(UIImage(named: "ulucamii")!)
        landmarkImages.append(UIImage(named: "truvaati")!)
        landmarkImages.append(UIImage(named: "saatkulesi")!)
        landmarkImages.append(UIImage(named: "agridagi")!)
        
        navigationItem.title = "Landmark Book"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            landmarkImages.remove(at: indexPath.row)
            landmarkNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landmarkNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choesenLanmarkNames = landmarkNames [indexPath.row]
        choesenLandmarkImages = landmarkImages [indexPath.row]
        
        performSegue(withIdentifier: "toimageViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toimageViewController"{
            let destinationVC = segue.destination as! imageVievController
            destinationVC.selectedLandmarkImage = choesenLandmarkImages
            destinationVC.selectedLandmarkName = choesenLanmarkNames
        }
    }

}

