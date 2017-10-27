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
        
        var json = JSON(jsonData)
        //print(json) --> Will print then json data in regular json format
        
        //Getting a string from a JSON Dictionary
        var dict = json["dict"].stringValue
        jsonTextBox.text = "The value from the 'dict' is:\n     --->\(dict)\n\n"
        
        //Getting an array of numbers from a JSON Array
        let arrayVals =  json["array"]
        jsonTextBox.text = jsonTextBox.text + "The values in 'array' are:\n     --->\(arrayVals[0]), and \(arrayVals[1])\n\n"
        
        // Looping through values
        let users = json["users"]
        for i in 0...users.count-1 {
            let text = ("User's name is \(users[i]["info"]["name"]), email is \(users[i]["info"]["email"])\n")
            jsonTextBox.text = jsonTextBox.text + text
        }
        //  Alternative, using path to element
        let path: [JSONSubscriptType] = ["users",1,"info","name"] // Path to the name jeff
        let name = json[path].stringValue
        let nameText = ("\nYou can use the a path to get a value, the path '['users',1,'info','name']' -- maps to \(name)\n\n")
        jsonTextBox.text = jsonTextBox.text + nameText
        
        
        // Errors: SwiftyJSON will prevent your app from crashing due to errors like "index out-of-bounds"
        if let outOfBounds = json["array"][9999].string {
            // Try to print
            print(outOfBounds)
        } else {
            // Print the error
            let errorText = String(describing: json["array"][9999].error)
            jsonTextBox.text = jsonTextBox.text + "Index out-of-bounds error on json[array][9999]: " +  errorText + "\n\n"
        }
        
        // Setting new values
        json["dict"] = JSON("New string value")
        dict = json["dict"].stringValue
        jsonTextBox.text = jsonTextBox.text + "The NEW value set for the 'dict' is:\n     -->'\(dict)'\n\n"
        
        
        // Merging json into another json
        // If writing both contain same key, the original value is overwritten
        //     If both are arrays with the same key, the new values get appended to the original
        let update: JSON = [
            "array": [11.11, 22.22, 33.33, 44.44, 55.55], // merges with original array
            "update" : "merged from second json",   // add a new key/value
            ]
        do {
            try json.merge(with: update)
            var updatedJson = "Array with new merged values:\n     "
            for i in 0...json["array"].count-1 {
                updatedJson += "\(json["array"][i]), "
            }
            jsonTextBox.text = jsonTextBox.text + updatedJson + "\n\n"
            jsonTextBox.text = jsonTextBox.text + "Key/Value 'update' merged in as new json value:\n     -->'\(json["update"])'"
        } catch {
            print(error)
        }
        
        
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

