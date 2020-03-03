//
//  ViewController.swift
//  simpsonBook
//
//  Created by Mustafa IŞIK on 3.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var simpsonArray = [Simpson]()
    var chosenSimpson : Simpson?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        let homerSimpson = Simpson(simpsonName: "Homer Simpson", simpsonJob: "Nuclear Safety", SimpsonImage: UIImage(named: "homer")!)
        let margeSimpson = Simpson(simpsonName: "Marge Simpson", simpsonJob: "House Wife", SimpsonImage: UIImage(named: "marge")!)
        let bartSimpson = Simpson(simpsonName: "Bart Simpson", simpsonJob: "Student", SimpsonImage: UIImage(named: "bart")!)
        let lisaSimpson = Simpson(simpsonName: "Lisa Simpson", simpsonJob: "Student", SimpsonImage: UIImage(named: "lisa")!)
        let maggieSimpson = Simpson(simpsonName: "Maggie Simpson", simpsonJob: "Baby", SimpsonImage: UIImage(named: "maggie")!)
        
        simpsonArray = [homerSimpson,margeSimpson,bartSimpson,lisaSimpson,maggieSimpson]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = simpsonArray [indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = simpsonArray [indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
    

}

