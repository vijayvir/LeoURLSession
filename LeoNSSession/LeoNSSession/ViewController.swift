//
//  ViewController.swift
//  LeoNSSession
//
//  Created by tecH on 10/02/20.
//  Copyright © 2020 vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Api()
        // Do any additional setup after loading the view.
    }
    func Api(){
        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)

        let url = URL(string: "https://httpbin.org/anything")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        // your post request data
        let postDict : [String: Any] = ["name": "axel",
                                        "favorite_animal": "fox"]

        guard let postData = try? JSONSerialization.data(withJSONObject: postDict, options: []) else {
            return
        }

        urlRequest.httpBody = postData

        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print("gotten json response dictionary is \n \(json)")
            // update UI using the response here
        }

        // execute the HTTP request
        task.resume()
    }

}

