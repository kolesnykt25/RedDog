import UIKit

class DayTrainingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaults = UserDefaults.standard
        let cell = tableView.dequeueReusableCell(withIdentifier: "trainingCell", for: indexPath) as! TrainingTableViewCell
        if (Day.shared.firstGame) {
            
            defaults.set(Date(), forKey: "dateOpen")
            Day.shared.firstGame = false
        }

        if let dateOpen = defaults.object(forKey: "dateOpen") as? Date {
            let modifiedDate = Calendar.current.date(byAdding: .day, value: indexPath.row, to: dateOpen)!
            let currentDate = Date()
            
            if (modifiedDate <= currentDate) {
                cell.label.text = "Day " + String(indexPath.row + 1)
            } else {
                cell.label.text = "Lock"
            }
        }
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        
        
        if let dateOpen = defaults.object(forKey: "dateOpen") as? Date {
            let modifiedDate = Calendar.current.date(byAdding: .day, value: indexPath.row, to: dateOpen)!
            let currentDate = Date()
            
            if (modifiedDate < currentDate) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "trainingDetails") as! TrainingDetailsViewController?
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                let alert = UIAlertController(title: "Wait", message: "You have tips to work today. Come for this tomorrow. There is no need to rush",         preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
}
