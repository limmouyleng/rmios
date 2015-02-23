import UIKit

class SiteModelViewController: UIViewController {
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
      var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as AnyObject!
      var msg = "No message"

      if(err != nil) {
        println(err!.localizedDescription)
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: '\(jsonStr)'")
        postCompleted(collection_list: "", msg: "Error")
      }
      else {
        if let collections_list: AnyObject = json  as AnyObject!{
          postCompleted(collection_list: collections_list, msg: "Collection list.")
        }

      }
    })
    
    task.resume()
  }

}
