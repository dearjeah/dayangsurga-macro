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
}
