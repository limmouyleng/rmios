import UIKit

class CollectionViewController: UITableViewController, UITableViewDelegate,UITableViewDataSource {

  var session: SessionModelViewController=SessionModelViewController()
  var collection: CollectionModelViewController = CollectionModelViewController()
  var auth_token = ""
  var collection_name:Array<String> = []

  let cellIdentifier = "collection_cell"

  @IBOutlet var collection_table: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let userDefault = NSUserDefaults.standardUserDefaults()
    if let auth_token = userDefault.stringForKey("auth_token")
    {
      self.auth_token = auth_token
    }

    var url = "http://192.168.1.11:3000/api/collections?auth_token=" + self.auth_token
    collection.getResponseHTTP(self.auth_token, url: url) { (collection_list: AnyObject, msg: String) -> () in
      for var i = 0 ; i<collection_list.count; i++ {
        if let collection_name_list = collection_list[i]["name"] as? NSString {
          self.collection_name.append(collection_name_list)
        }
      }
      self.refresh(self)
    }
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return collection_name.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell

    cell.textLabel.text = self.collection_name[indexPath.row]

    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    println("You selected cell #\(indexPath.row)!")
  }

  func refresh(sender: AnyObject){
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      self.collection_table.reloadData()
    })
  }
}
