//
//  ExpertDetailViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ExpertDetailViewController: MVVMViewController<ExpertDetailViewModel> {
    
    var index: Int?
    var expertDetail = Expert_Profile()
    
    @IBOutlet weak var expertDetailTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setUpViewModel()
        registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        expertDetailTable.reloadData()
    }
    
    func setUpViewModel(){
        self.viewModel = ExpertDetailViewModel()
        expertDetail = (self.viewModel?.getExpertInfo(indexPath: index ?? 0))!
    }
    
    func sendToWhatsApp(message: String){
        let urlWhatsApp = "https://wa.me/\(expertDetail.phone_number ?? "")/?text=\(message)"
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
}

// MARK: Initial Setup
extension ExpertDetailViewController {
    func setupView(){
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Profile"
    }
}

// MARK: Protocol
extension ExpertDetailViewController: goToLinkedIn {
    func goToLink() {
        if let url = URL(string: expertDetail.linkedIn!){
            UIApplication.shared.open(url)
        }
    }
}

// MARK: Table View
extension ExpertDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func registerTableView(){
        expertDetailTable.register(UINib.init(nibName: "ExpertDetailInfoCell", bundle: nil), forCellReuseIdentifier: "ExpertDetailInfoCell")
        expertDetailTable.register(UINib.init(nibName: "ExpertProfileCell", bundle: nil), forCellReuseIdentifier: "ExpertProfileCell")
        expertDetailTable.register(UINib.init(nibName: "ExpertButtonCell", bundle: nil), forCellReuseIdentifier: "ExpertButtonCell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 3{
                goToLink()
            }
        } else if indexPath.section == 2 {
            let expertName = expertDetail.expert_name
            sendToWhatsApp(message: "Halo, perkenalkan saya\nNama:\nPekerjaan:\nSaya adalah pengguna aplikasi Aigoe. Saya ingin bertanya tentang proses rekrutmen dan seleksi kepada Ibu/Bapak \(expertName ?? "").")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 225
        } else if indexPath.section == 1 {
            if indexPath.row == 2{
                return 80
            }else if indexPath.row == 3{
                return 58
            }else{
                return 60
            }
        } else {
            if UIDevice.current.modelName == "iPhone10,4" {
                return 120
            } else if UIDevice.current.modelName == "iPhone12,1" {
                return 290
            } else if UIDevice.current.modelName == "iPhone13,2" {
                return 245
            }
        }
        return CGFloat()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ExpertProfileCell", for: indexPath)as! ExpertProfileCell
            cell.expertImage.image = UIImage(data: expertDetail.expert_image ?? Data())
            cell.nameLabel.text = expertDetail.expert_name?.uppercased()
            cell.availibiltyLabel.text = "Availability: \(expertDetail.day_avail_time ?? "N/A")\n\(expertDetail.time_avail_time ?? "N/A")"
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            if indexPath.row == 2 {
                let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ExpertSummaryCell", for: indexPath)as! ExpertSummaryCell
                cell.cellLabel.text = "Summary"
                cell.descriptionLabel.text = expertDetail.expertise
                return cell
            }else if indexPath.row == 3{
                let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ContactExpertCell", for: indexPath)as! ContactExpertCell
                return cell
            }else{
                let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ExpertDetailInfoCell", for: indexPath)as! ExpertDetailInfoCell
                cell.selectionStyle = .none
                if indexPath.row == 0{
                    cell.cellLabel.text = "Background"
                    cell.descriptionLabel.text = expertDetail.title_on_list
                }else{
                    cell.cellLabel.text = "Experience"
                    cell.descriptionLabel.text = expertDetail.experience
                }
                return cell
            }
        } else {
            let cell = expertDetailTable.dequeueReusableCell(withIdentifier: "ExpertButtonCell", for: indexPath)as! ExpertButtonCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
