//
//  ExpertDetailViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ExpertDetailViewController: MVVMViewController<ExpertDetailViewModel>, UITableViewDelegate, UITableViewDataSource, goToLinkedIn {
    
    func goToLink() {
        if let url = URL(string: expertDetail.linkedIn!){
            UIApplication.shared.open(url)
        }
    }
    
    var index: Int?
    var expertDetail = Expert_Profile()

    @IBOutlet weak var expertDetailImage: UIImageView!
    @IBOutlet weak var expertName: UILabel!
    @IBOutlet weak var expertAvailability: UILabel!
    @IBOutlet weak var contactExpertButton: UIButton!
    @IBOutlet weak var expertDetailTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Profile"
        expertDetailTable.register(UINib.init(nibName: "ExpertDetailInfoCell", bundle: nil), forCellReuseIdentifier: "ExpertDetailInfoCell")
        setUpViewModel()
        expertDetailImage.image = UIImage(data: expertDetail.expert_image!)
        expertName.text = expertDetail.expert_name?.uppercased()
        expertAvailability.text = "Availability: \(expertDetail.day_avail_time ?? "N/A")\n\(expertDetail.day_avail_time ?? "N/A")"
        contactExpertButton.dsLongFilledPrimaryButton(withImage: false, text: "  Ask in WhatsApp")
        expertDetailTable.reloadData()
    }
    
    func setUpViewModel(){
        self.viewModel = ExpertDetailViewModel()
        expertDetail = (self.viewModel?.getExpertInfo(indexPath: index ?? 0))!
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func sendToWhatsApp(message: String){
        let urlWhatsApp = "https://wa.me/6285311689228/?text=\(message)"
        if let urlString = urlWhatsApp.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed){
            if let whatsAppURL = NSURL(string: urlString){
                if UIApplication.shared.canOpenURL(whatsAppURL as URL){
                    UIApplication.shared.open(whatsAppURL as URL, options: [:], completionHandler: nil)
                }else{
                    print("Cannot open WhatsApp")
                }
            }
        }
    }
    
    @IBAction func askWhatsAppTapped(_ sender: Any) {
//        print("Ask \(expertDetail.expert_name ?? nil) on whatsapp")
        sendToWhatsApp(message: "Hello, my name is: \nI am a user of aigoe.")
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return 80
        }else if indexPath.row == 3{
            return 58
        }else{
            return 60
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ExpertSummaryCell", for: indexPath)as! ExpertSummaryCell
            cell.cellLabel.text = "Summary"
            cell.descriptionLabel.text = expertDetail.expertise
            return cell
        }else if indexPath.row == 3{
            let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ContactExpertCell", for: indexPath)as! ContactExpertCell
            cell.setUpProtocol(dlgt: self)
            goToLink()
            return cell
        }else{
            let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ExpertDetailInfoCell", for: indexPath)as! ExpertDetailInfoCell
            if indexPath.row == 0{
                cell.cellLabel.text = "Background"
                cell.descriptionLabel.text = expertDetail.title_on_list
            }else{
                cell.cellLabel.text = "Experience"
                cell.descriptionLabel.text = expertDetail.experience
            }
            return cell
        }
       
    }

}
