//
//  ExpertInfoViewController.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 09/11/21.
//

import UIKit

class ExpertInfoViewController: MVVMViewController<ExpertInfoViewModel> ,UITableViewDelegate, UITableViewDataSource{
   
    var content = ExpertInfoViewModel.expertInfoData
    @IBOutlet weak var infoPageImage: UIImageView!
    @IBOutlet weak var infoPageInstructionTable: UITableView!
    @IBOutlet weak var infoPageDismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoPageImage.image = UIImage.imgExpertInfo
        infoPageInstructionTable.register(UINib(nibName: "ExpertInfoCell", bundle: nil), forCellReuseIdentifier: "ExpertInfoCell")
        infoPageDismissButton.dsLongFilledPrimaryButton(withImage: false, text: "OK, I Understand")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoPageInstructionTable.dequeueReusableCell(withIdentifier: "ExpertInfoCell", for: indexPath)as! ExpertInfoCell
        cell.instructionText.text = content[indexPath.row]
        
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.numberLabel.font = UIFont(name: "SF Pro Display-Medium", size: 24.0)
        print(UIFont.familyNames)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
