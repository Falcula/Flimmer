//
//  ViewController.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-19.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var ResponceTextView: UITextView!
    
    let mediaAPIService = MediaAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func GetData(_ sender: Any) {
        
        let apipath = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=288c571a21597171ec16fe1a8af882bc&text=dog&per_page=10&page=1&format=json&nojsoncallback=1&auth_token=72157691885586851-3c57a28ba2044c4d&api_sig=1de96041f74710f0e2ff9067e834e2db"
        
        let url = URL(string: apipath)
        
        self.mediaAPIService.executeAPIRequest(url: url!) { (resposeData, error) in
            
            DispatchQueue.main.async {
                
                if let errorUnwrapped = error {
                    print(errorUnwrapped.localizedDescription)
                }
                
                if let responseDataUnWrapped = resposeData{
                    self.ResponceTextView.text = responseDataUnWrapped.description
                }
                
                
            }
        }
    }
    
}

