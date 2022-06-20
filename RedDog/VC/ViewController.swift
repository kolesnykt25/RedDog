import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/list/all") { str in
            print("=)")

        }
    }
}

