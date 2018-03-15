//
//  LoginViewController.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-21.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import UIKit
import Auth0


class LoginViewController: UIViewController {

    // Create an instance of the credentials manager for storing credentials
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.credentialsManager.hasValid() {
            presentHostedLoginView()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentHostedLoginView() {
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://reaktor.eu.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    
                    
                let tokenUrl = "https://api.flickr.com/services/rest/?method=flickr.auth.oauth.getAccessToken&api_key=273d2b7da08fa454abb62bfbedc8e62a&format=json&nojsoncallback=1&auth_token=72157663957132657-ecac24af94adf6d2&api_sig=ae99aed987877be2f6058a815d6adcde"
                    let url = URL(string: tokenUrl)
                    
                    URLSession.shared.dataTask(with: url!) { (data, response, error) in
                        do {
                            
                        } catch let error {
                       
                            print(error)
                            return
                        }
                    
                    // Store the credentials
                    self.credentialsManager.store(credentials: credentials)
                    
                    if self.credentialsManager.hasValid() {
                        self.performSegue(withIdentifier: "navigation", sender: self)
                    }
                }
        }
    }
    }
    
    // MARK: - Private
    fileprivate func showSuccessAlert(_ accessToken: String) {
        let alert = UIAlertController(title: "Success", message: "accessToken: \(accessToken)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    


func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
    guard
        let path = bundle.path(forResource: "Auth0", ofType: "plist"),
        let values = NSDictionary(contentsOfFile: path) as? [String: Any]
        else {
            print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
            return nil
    }
    
    guard
        let clientId = values["ClientId"] as? String,
        let domain = values["Domain"] as? String
        else {
            print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
            print("File currently has the following entries: \(values)")
            return nil
    }
    return (clientId: clientId, domain: domain)
}

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



