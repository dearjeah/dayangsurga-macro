//
//  GenerateResumeViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit
import PDFKit

class GenerateResumeController: MVVMViewController<GenerateResumeViewModel> {

    @IBOutlet weak var resumePreviewImage: UIImageView!
    @IBOutlet weak var resumeName: UILabel!
    @IBOutlet weak var resumeDate: UILabel!
    @IBOutlet weak var editResumeNameButton: UIButton!
    @IBOutlet weak var previewResumeButton: UIButton!
    @IBOutlet weak var exportResumeButton: UIButton!
    @IBOutlet weak var finishCreateResume: UIButton!
    var userResume: User_Resume? = nil
    var selectedTemplate = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finishCreateResume.dsLongUnfilledButton(isDelete: false, text: "Finish")
        exportResumeButton.backgroundColor = UIColor.primaryBlue
        exportResumeButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        exportResumeButton.layer.cornerRadius = 18
        exportResumeButton.tintColor = .white
        resumePreviewImage.layer.borderColor = UIColor.primaryBlue.cgColor
        resumePreviewImage.layer.shadowOpacity = 0.5
        resumePreviewImage.layer.shadowRadius = 1
        resumePreviewImage.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationItem.title = "Preview Resume"
        self.viewModel = GenerateResumeViewModel()
        let date = Date()
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "E, dd MMM YYYY"
           resumeDate.text = dateFormatter.string(from: date)
    }

    @IBAction func previewDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PreviewResumeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPreviewResume") as! PreviewResumeViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.backgroundColor = UIColor.primaryBlue
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationItem.backButtonTitle = "Preview"
        let pdfCreator = PDFCreator(dataInput: "Test", userResume: userResume)
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
            self.resumeName.text = textField?.text
            guard let resumeID = self.userResume?.resume_id else {return}
            guard (self.viewModel?.updateResumeName(resume_id: resumeID, resumeName: self.resumeName.text ?? "")) != nil else{
                return print("Failed to update resume name")
            }
        }))
        editResume.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
        self.present(editResume, animated: true, completion: nil)
    }
    
    @IBAction func finishDidTap(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func exportDidTap(_ sender: Any) {
        let pdfCreator = PDFCreator(dataInput: "Test", userResume: userResume)
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
