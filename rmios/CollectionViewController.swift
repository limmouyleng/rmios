import UIKit

class CollectionViewController: UITableViewController, UITableViewDelegate,UITableViewDataSource {

  var session: SessionModelViewController=SessionModelViewController()
  var collection: CollectionModelViewController = CollectionModelViewController()
  var auth_token = ""
  var collection_name:Array<String> = []

  override func viewDidLoad() {
    super.viewDidLoad()

    println("auth token : \(self.auth_token)")

    var url = "http://192.168.123.15:3000/api/collections?auth_token=" + self.auth_token
    collection.getResponseHTTP(self.auth_token, url: url) { (collection_list: AnyObject, msg: String) -> () in
      for var i = 0 ; i<collection_list.count; i++ {
        if let collection_name_list = collection_list[i]["name"] as? NSString {
          self.collection_name.append(collection_name_list)
        }
      }
      println("collection _ name : \(self.collection_name)")
    }

  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    println("cell")


    let cell = tableView.dequeueReusableCellWithIdentifier("collection_cell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel.text = "test \(indexPath.row)"
//    cell.textLabel.text = self.collection_name[indexPath.row]
    return cell
  }
}
