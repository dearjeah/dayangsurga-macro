//
//  GenerateResumeViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class GenerateResumeController: MVVMViewController<GenerateResumeViewModel> {

    @IBOutlet weak var resumePreviewImage: UIImageView!
    @IBOutlet weak var resumeName: UILabel!
    @IBOutlet weak var resumeDate: UILabel!
    @IBOutlet weak var editResumeNameButton: UIButton!
    @IBOutlet weak var previewResumeButton: UIButton!
    @IBOutlet weak var exportResumeButton: UIButton!
    @IBOutlet weak var finishCreateResume: UIButton!
    var userResume: User_Resume?
    override func viewDidLoad() {
        super.viewDidLoad()
        exportResumeButton.dsLongFilledPrimaryButton(withImage: false, text: " Export Resume")
        exportResumeButton.tintColor = .white
        finishCreateResume.dsLongUnfilledButton(isDelete: false, text: "Finish")
        resumePreviewImage.layer.borderColor = UIColor.primaryBlue.cgColor
        resumePreviewImage.layer.shadowOpacity = 0.5
        resumePreviewImage.layer.shadowRadius = 1
        resumePreviewImage.layer.shadowColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? PreviewResumeViewController
        let dataInput = "Test"
        
        let pdfCreator = PDFCreator(
            dataInput: dataInput, userResume: userResume
        )
        
        vc?.documentData = pdfCreator.createFlyer()
    }
    
    @IBAction func previewDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PreviewResumeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPreviewResume") as! PreviewResumeViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func editDidTap(_ sender: Any) {
        print("Edit button tapped")
    }
    
    @IBAction func finishDidTap(_ sender: Any) {
        print("Finish button tapped")
    }
    
    @IBAction func exportDidTap(_ sender: Any) {
        print("Export button tapped")
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
