//
//  SignupViewController.swift
//  rmios
//
//  Created by limmouyleng on 2/2/15.
//  Copyright (c) 2015 limmouyleng. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

  var session: SessionModelViewController=SessionModelViewController()

  @IBOutlet var email_signup_txt: UITextField!

  @IBOutlet var password_signup_txt: UITextField!

  @IBOutlet var password_confirmation_signup_txt: UITextField!

  @IBOutlet var phone_number_signup_txt: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func signup_btn(sender: AnyObject) {

    var url = "http://192.168.1.113:3000/api/users.json"

    var user = ["email": email_signup_txt.text, "password": password_signup_txt.text, "password_confirmation":password_confirmation_signup_txt.text] as Dictionary<String, String>

    var params = ["user": user] as Dictionary<String, Dictionary<String, String>>

    session.postRequestHTTP(params, url: url) { (succeeded: Bool, msg: String, auth_token: String) -> () in

      var alert = UIAlertView(title: "Success!", message: msg, delegate: nil, cancelButtonTitle: "Okay.")
      if(succeeded) {
        alert.title = "Success!"
      }
      else {
        alert.title = "Failed : ("
        alert.message = msg
      }

      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        alert.show()
      })
    }

    self.navigationController?.popToRootViewControllerAnimated(true)
  }

  @IBAction func alr_have_account(sender: AnyObject) {
    self.navigationController?.popToRootViewControllerAnimated(true)
  }


}
