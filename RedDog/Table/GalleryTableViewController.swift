import UIKit

class GalleryTableViewController: UITableViewController {
    
    //    var images = [UIImage(named: "ruby1"),UIImage(named: "playButton"),UIImage(named: "lapka")]
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        var arrayString = defaults.stringArray(forKey: "arr") ?? [String]()
        if (arrayString.count >= 1) {
            for i in 0...arrayString.count - 1 {
                let url = URL(string: arrayString[i])
                if let data = try? Data(contentsOf: url!)
                {
                    let image: UIImage = UIImage(data: data)!
                    images.append(image)
                }
            }
            self.tableView.separatorStyle = .none
            self.tableView.register(ImageViewCell.self, forCellReuseIdentifier: "ImageViewCell")
        } else {
            let label = UILabel()
            label.text =  "Your gallery is empty, go to Random dog and add liked dog"
            label.textAlignment = .center
            label.numberOfLines = 0
            label.preferredMaxLayoutWidth = 0.8 * view.frame.width
            label.font = UIFont.systemFont(ofSize: 30)
            label.frame = CGRect(x: view.frame.width/2 - label.intrinsicContentSize.width/2, y: view.frame.height/2 - label.intrinsicContentSize.height ,width:label.intrinsicContentSize.width,height:label.intrinsicContentSize.height)
            self.view.addSubview(label)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell") as! ImageViewCell
        cell.mainImageView.image = images[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = images[indexPath.row]
        let imageCrop = currentImage.getCropRatio()
        return tableView.frame.width / imageCrop
    }
    
    
    
}
extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width/self.size.height)
        return widthRatio
    }
}
