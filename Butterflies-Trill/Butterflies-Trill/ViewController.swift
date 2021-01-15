//
//  ViewController.swift
//  Butterflies-Trill
//
//  Created by Uditi Sharma on 14/01/2021.
//

import UIKit

class ViewController: UIViewController {

// alert text: Hi! thanks for considering my application to be an iOS development intern at Trill! i would be honored to work at this amazing start up and create an impact on the world using code ✨
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        label1.text = "Danaus \n Plexipus"
        label2.text = "Morpho \n Pelides"
        label3.text = "Delias Eucharia"
        
        let alert = UIAlertController(title: "hi!", message: "thanks for considering my application to be an iOS development intern at Trill! i would be honored to work at this amazing start up and create an impact on the world using code ✨", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Get started!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        
        displayQuote()
    }

     func displayQuote() {
        guard let url = URL(string: "http://quotes.rest/qod.json") else { return }
        

        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    guard let quotes = (jsonResult["contents"] as? [String: Any])?["quotes"] as? [Any],
                        let firstQuote = quotes[0] as? [String: Any],
                        let quoteText = firstQuote["quote"] as? String else { return }

                    // Change the text view to display quote on the main thread
                    DispatchQueue.main.async {
                        self.quotesLabel.text = "\(quoteText)"
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

}
