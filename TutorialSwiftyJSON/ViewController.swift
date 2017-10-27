//
//  ViewController.swift
//  TutorialSwiftyJSON
//
//  Created by iMac03 on 2017-10-26.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let json = JSON(jsonData)
        //print(json) --> Will print then json data in regular json format
        
        //Getting a string from a JSON Dictionary
        let dict = json["dict"].stringValue
        jsonTextBox.text = "The value from the 'dict' is \(dict)\n\n"
        
        //Getting an array of numbers from a JSON Array
        let arrayVals =  json["array"]
        jsonTextBox.text = jsonTextBox.text + "The values in 'array' are \(arrayVals[0]), and \(arrayVals[1])\n\n"
        
        // Looping through values
        let users = json["users"]
        for i in 0...users.count-1 {
            let text = ("User's name is \(users[i]["info"]["name"]), email is \(users[i]["info"]["email"])\n\n")
            jsonTextBox.text = jsonTextBox.text + text
        }
        //  Alternative, using path to element
        let path: [JSONSubscriptType] = ["users",1,"info","name"] // Path to the name jeff
        let name = json[path].stringValue
        let nameText = ("You can use the a path to get a value, the path '['users',1,'info','name']' -- maps to \(name)")
        jsonTextBox.text = jsonTextBox.text + nameText
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var jsonTextBox: UITextView!
    
    var jsonData: JSON = [
        "dict" : "SomeDictionaryStringValue",
        "array": [12.34, 56.78],
        "users": [
            [
                "id": 987654,
                "info": [
                    "name": "jack",
                    "email": "jack@gmail.com"
                ],
                "feeds": [98833, 23443, 213239, 23232]
            ],
            [
                "id": 654321,
                "info": [
                    "name": "jeff",
                    "email": "jeff@gmail.com"
                ],
                "feeds": [12345, 56789, 12423, 12412]
            ]
        ]
    ]
    
    
    
    

}

