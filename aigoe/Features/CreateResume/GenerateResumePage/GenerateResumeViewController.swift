//
//  GenerateResumeViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit
import PDFKit

class GenerateResumeController: MVVMViewController<GenerateResumeViewModel> {
    
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var resumePreviewImage: UIImageView!
    @IBOutlet weak var resumeName: UILabel!
    @IBOutlet weak var resumeDate: UILabel!
    @IBOutlet weak var editResumeNameButton: UIButton!
    @IBOutlet weak var previewResumeButton: UIButton!
    @IBOutlet weak var exportResumeButton: UIButton!
    @IBOutlet weak var finishCreateResume: UIButton!
    var userResume: User_Resume?
    var userResumeContent = Resume_Content()
    var resumeContentId = String()
    var selectedTemplate = Int()
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PreviewResumeViewController {
            let pdfCreator = PDFCreator(resumeContent: userResumeContent, userResume: userResume, selectedTemplate: selectedTemplate)
            vc.documentData = pdfCreator.createPDF()
        }
    }
    
    //MARK: Button Action
    @IBAction func previewDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PreviewResumeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPreviewResume") as! PreviewResumeViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.backgroundColor = UIColor.primaryBlue
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationItem.backButtonTitle = "Preview"
        userResume?.template_id = Int32(selectedTemplate)
        userResumeContent.resumeTemplate_id = Int32(selectedTemplate)
        
        let pdfCreator = PDFCreator(resumeContent: userResumeContent, userResume: userResume, selectedTemplate: selectedTemplate)
        vc.documentData = pdfCreator.createPDF()
    }
    
    
    @IBAction func editDidTap(_ sender: Any) {
        print("Edit button tapped")
        let editResume = UIAlertController(title: "Resume Name", message: "What would you name this resume?", preferredStyle: .alert)

        editResume.addTextField { (textField) in
            textField.placeholder = "Input your resume name"
        }
        
        editResume.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak editResume] (_) in
            let textField = editResume?.textFields![0]
            let data = self.changeName(resumeName: textField?.text ?? "")
            
            if data {
                self.resumeName.text = textField?.text
            } else {
                print("change name failed")
            }
        }))
        editResume.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
        self.present(editResume, animated: true, completion: nil)
    }
    
    func changeName(resumeName: String) -> Bool {
        let resumeID = self.userResume?.resume_id ?? ""
        let userResumeRepo = UserResumeRepository.shared
        let changeName = userResumeRepo.updateResumeName(resume_id: resumeID, newResumeName: resumeName)
        
        if changeName {
            return true
        } else {
            print("Failed to update resume name")
            return false
        }
    }
    
    @IBAction func finishDidTap(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("clearStep"), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func exportDidTap(_ sender: Any) {
        print("Export button tapped")
        let pdfCreator = PDFCreator(resumeContent: userResumeContent, userResume: userResume, selectedTemplate: selectedTemplate)
        let pdfData = pdfCreator.createPDF()
        let temporaryFolder = FileManager.default.temporaryDirectory
        let fileName = "\(resumeName.text!).pdf"
        let temporaryFileURL = temporaryFolder.appendingPathComponent(fileName)
    
        do {
            try pdfData.write(to: temporaryFileURL)
            let vc = UIActivityViewController(activityItems: [temporaryFileURL], applicationActivities: nil)
            present(vc, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
}

//MARK: Initial Setup
extension GenerateResumeController {
    func getResumeContentData() {
        let data = self.viewModel?.getResumeContentData(resumeId: resumeContentId)
        userResumeContent = data ?? Resume_Content()
    }
    
    func displaySetup(){
        let image = UIImage(data: userResume?.image ?? Data())
        resumeName.text = userResume?.name ?? "Resume Title"
        exportResumeButton.backgroundColor = UIColor.primaryBlue
        exportResumeButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        exportResumeButton.layer.cornerRadius = 18
        exportResumeButton.tintColor = .white
        resumePreviewImage.image = image
        resumePreviewImage.layer.shadowOpacity = 0.5
        resumePreviewImage.layer.shadowRadius = 3
        resumePreviewImage.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationItem.title = "Preview Resume"
        finishCreateResume.dsLongUnfilledButton(isDelete: false, text: "Finish")
        
        let date = Date()
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "E, dd MMM YYYY"
           resumeDate.text = dateFormatter.string(from: date)
    }
}
