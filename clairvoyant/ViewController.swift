//
//  ViewController.swift
//  clairvoyant
//
//  Created by Joseph Sungpil Choi on 31/12/2017.
//  Copyright © 2017 Joseph Sungpil Choi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var inputEmail: NSTextField!
    @IBOutlet weak var inputPassword: NSSecureTextField!
    @IBOutlet weak var inputKorbitPublicKey: NSSecureTextField!
    @IBOutlet weak var inputKorbitPrivateKey: NSSecureTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func handleGenerateToken(_ sender: Any) {
        let email = inputEmail.stringValue
        if email.isEmpty {
            print("Forgot to input email")
            return
        }
        
        let password = inputPassword.stringValue
        if password.isEmpty {
            print("Forgot to input password")
            return
        }
        
        let korbitPublicKey = inputKorbitPublicKey.stringValue
        if korbitPublicKey.isEmpty {
            print("Forgot to input Korbit public key")
            return
        }
        
        let korbitPrivateKey = inputKorbitPrivateKey.stringValue
        if korbitPrivateKey.isEmpty {
            print("Forgot to input Korbit private key")
            return
        }
        
        let myUrl = URL(string: "https://api.korbit.co.kr/v1/oauth2/access_token?client_id=\(korbitPublicKey)&client_secret=\(korbitPrivateKey)&username=\(email)&password=\(password)&grant_type=password")
        if let url = myUrl {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            
            let task = URLSession.shared.dataTask(with: req) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    if let err = error {
                        print("error=\(err)")
                        return
                    } else {
                        print("fundamental network error")
                        return
                    }
                    
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    if let res = response {
                        print("response = \(res)")
                    }
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                }
            }
            task.resume()
        } else {
            print("URL construction failed")
            return
        }
    }
}

