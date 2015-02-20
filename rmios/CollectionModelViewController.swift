//
//  CollectionModelViewController.swift
//  rmios
//
//  Created by limmouyleng on 2/6/15.
//  Copyright (c) 2015 limmouyleng. All rights reserved.
//

import UIKit

class CollectionModelViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  func getCollection(auth_token:String){
    var url = "http://192.168.1.113:3000/api/collections?auth_token=" + auth_token
    
  }

  func getResponseHTTP(auth_token: String, url : String, postCompleted : (collection_list: AnyObject, msg: String) -> ()) {
    var url = NSURL(string: url)
    var request = NSMutableURLRequest(URL: url!)
    var session = NSURLSession.sharedSession()
    request.HTTPMethod = "GET"

    var err: NSError?
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
      var strData = NSString(data: data, encoding: NSUTF8StringEncoding)

      var err: NSError?
      var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as AnyObject!
      var msg = "No message"

      if(err != nil) {
        println(err!.localizedDescription)
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: '\(jsonStr)'")
        postCompleted(collection_list: "", msg: "Error")
      }
      else {
        if let collections_list = json  as AnyObject!{
          postCompleted(collection_list: collections_list, msg: "Collection list.")
        }

      }
    })

    task.resume()
  }

  func parseJSON(inputData: NSData) -> NSDictionary{
    var error: NSError?
    var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
    return boardsDictionary
  }


}
