//
//  SessionViewController.swift
//  rmios
//
//  Created by limmouyleng on 2/6/15.
//  Copyright (c) 2015 limmouyleng. All rights reserved.
//

import UIKit

class SessionModelViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

        // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  func postRequestHTTP(params : Dictionary<String, Dictionary<String, String>>, url : String, postCompleted : (succeeded: Bool, msg: String, auth_token: String) -> ()) {
    var url = NSURL(string: url)
    var request = NSMutableURLRequest(URL: url!)
    var session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"

    var err: NSError?
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
      var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
      var err: NSError?
      var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary

      var msg = "No message"

      if(err != nil) {
        println(err!.localizedDescription)
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: '\(jsonStr)'")
        postCompleted(succeeded: false, msg: "Error", auth_token: "")
      }
      else {
        if let parseJSON = json {
          if let success = parseJSON["success"] as? Bool {
            if let auth_token = parseJSON["auth_token"] as? String{
              postCompleted(succeeded: success, msg: "Logged in.", auth_token: auth_token)
            }
          }
          return
        }
        else {
          let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
          println("Error could not parse JSON: \(jsonStr)")
          postCompleted(succeeded: false, msg: "Error", auth_token: "")
        }
      }
    })

    task.resume()
  }


}
