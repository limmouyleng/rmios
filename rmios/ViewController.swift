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

  @IBAction func login_btn(sender: AnyObject) {

    var url = "http://192.168.1.11:3000/api/users/sign_in.json"

    var user = ["email": email_txt.text, "password": password_txt.text] as Dictionary<String, String>

    var params = ["user": user] as Dictionary<String, Dictionary<String, String>>

    session.postRequestHTTP(params, url: url) { (succeeded: Bool, msg: String, auth_token: String) -> () in
      if(succeeded){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(auth_token, forKey: "auth_token")
      }
    }
  }

}