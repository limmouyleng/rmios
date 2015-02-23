import UIKit

class SiteViewController: UIViewController {

  var site: SiteModelViewController = SiteModelViewController()

  override func viewDidLoad() {
    super.viewDidLoad()

    let userDefault = NSUserDefaults.standardUserDefaults()
    if let auth_token = userDefault.stringForKey("auth_token")
    {
      if let cId = userDefault.stringForKey("cId"){
        var url = "http://192.168.0.102:3000/api/collections/\(cId)/sites.json?auth_token=\(auth_token)"
        site.getResponseHTTP(auth_token, url: url) { (site_list: AnyObject, msg: String) -> () in

        }
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func btn_add_site(sender: AnyObject) {
    
  }
}
