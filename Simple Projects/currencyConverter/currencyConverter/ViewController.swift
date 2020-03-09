//
//  ViewController.swift
//  currencyConverter
//
//  Created by Mustafa IŞIK on 9.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        // Request
        // Response
        // Parcing
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=e5eadc3f9256c2bb6c80cabda558cea7&format=1")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                if data != nil{
                    do {
                       let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse ["rates"] as?  [String: Any]{
                                if let cad = rates ["CAD"] as? Double{
                                    self.cadLabel.text = "(Canada) CAD: \(cad)"
                                }
                                if let chf = rates ["CHF"] as? Double{
                                    self.chfLabel.text = "(Isvicre) CHF: \(chf)"
                                }
                                if let gbp = rates ["GBP"] as? Double{
                                    self.gbpLabel.text = "(Ingiltere) GBP: \(gbp)"
                                }
                                if let jpy = rates ["JPY"] as? Double{
                                    self.jpyLabel.text = "(Japonya) JPY: \(jpy)"
                                }
                                if let usd = rates ["USD"] as? Double{
                                    self.usdLabel.text = "(Amerika) USD: \(usd)"
                                }
                                if let tl = rates ["TRY"] as? Double{
                                    self.tlLabel.text = "(Turkiye) TL: \(tl)"
                                }
                                
                            }
                        }
                        
                    } catch {
                        print("Eroor...")
                    }
                }
            }
        }
        task.resume()
    }
    
}

