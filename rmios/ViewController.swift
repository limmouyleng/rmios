import UIKit

class ViewController: UIViewController {

  var session: SessionModelViewController=SessionModelViewController()

  @IBOutlet var email_txt: UITextField!
  @IBOutlet var password_txt: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.email_txt.text = "mouyleng@instedd.org"
    self.password_txt.text = "mouyleng123"

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func login_btn(sender: AnyObject) {

    var url = "http://192.168.123.15:3000/api/users/sign_in.json"

    var user = ["email": email_txt.text, "password": password_txt.text] as Dictionary<String, String>

    var params = ["user": user] as Dictionary<String, Dictionary<String, String>>

    session.postRequestHTTP(params, url: url) { (succeeded: Bool, msg: String, auth_token: String) -> () in
      if(succeeded) {

        var collection_vc = CollectionViewController()

        collection_vc.auth_token = auth_token
//        self.presentViewController(collection_vc, animated: true, completion: nil)
        println("first : \(collection_vc.auth_token)")
      }
    }
  }
  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.identifier == "login-segue" {
//      let collection_vc = segue.destinationViewController as CollectionViewController
//      println("segue")
//    }
//  }
}

