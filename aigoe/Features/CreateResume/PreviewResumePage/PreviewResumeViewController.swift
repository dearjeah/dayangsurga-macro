//
//  PreviewResumeViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit
import PDFKit

class PreviewResumeViewController: MVVMViewController<PreviewResumeViewModel> {
    @IBOutlet weak var pdfView: PDFView!
    var selectedData = User_Resume()
    var dataInput = "Test"
    public var documentData: Data?
    
    override func viewDidLoad() {
      super.viewDidLoad()
        self.navigationItem.titleView?.backgroundColor = UIColor.primaryBlue
        
      if let data = documentData {
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
      }
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
