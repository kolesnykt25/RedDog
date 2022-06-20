import UIKit

var breedLink = [String:String]()

class AllBreedViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var breeds = ["corgi", "akita", "practiseButton"]
    
    var images = [UIImage(named: "ruby1"), UIImage(named: "ruby2"), UIImage(named: "practiseButton")]

    @IBOutlet weak var breedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        breedTableView.delegate = self
        breedTableView.dataSource = self
        breedTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = breedTableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath) as! BreedCellTableViewCell
        
        let nameOfBreed = allBreeds[indexPath.row]
        

        var linkStr = "https://dog.ceo/api/breed/" + nameOfBreed + "/images/random"
        cell.breedLabel.text = nameOfBreed.capitalized
        
        NetworkManager.sharedInstance.parseJSON(urlStr: linkStr) { str in
            breedLink[nameOfBreed] = str
            UIView.transition(with: cell.dogImageView, duration: 1, options: .transitionCrossDissolve) {
                cell.dogImageView.imageFromServerURL(urlString: str) {
                }
            }
        }
        
        
//        NetworkManager.sharedInstance.parseJSON(urlStr: linkStr) {
//            breedLink[nameOfBreed] = NetworkManager.sharedInstance.linkString
//            UIView.transition(with: cell.dogImageView, duration: 1, options: .transitionCrossDissolve) {
//                cell.dogImageView.imageFromServerURL(urlString: NetworkManager.sharedInstance.linkString) {
//                }
//            }
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "pictureByBreed") as! PictureByBreedViewController?
        vc!.nameOfBreed = allBreeds[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    

}

