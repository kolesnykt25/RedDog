import UIKit

class ToolsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func openAllBreeds(_ sender: Any) {
        
        NetworkManager.sharedInstance.parseAllBreedsJSON {
            DispatchQueue.main.async {
                self.openVCAllBreeds()
            }
        }
    }
    
    func openVCAllBreeds() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allBreeds") as! AllBreedViewController?
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
