//
//  ResumeTemplateViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ResumeTemplateViewController: MVVMViewController<ResumeTemplateViewModel> {

    var templateData = ["imgResumeTemplateArial","imgResumeTemplateGeorgia","imgResumeTemplateHeletvica"]
    
    @IBOutlet weak var resumeTemplateCollection: UICollectionView!
    @IBOutlet weak var resumeTemplatePageController: UIPageControl!
    @IBOutlet weak var selectResumeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resumeTemplateCollection.register(UINib.init(nibName: "ResumeTemplateCell", bundle: nil), forCellWithReuseIdentifier: "ResumeTemplateCell")
        selectResumeButton.dsLongFilledPrimaryButton(withImage: false, text: "Use Template")
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

extension ResumeTemplateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return templateData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resumeTemplateCollection.dequeueReusableCell(withReuseIdentifier: "ResumeTemplateCell", for: indexPath)as! ResumeTemplateCell
        
        cell.resumeTemplateImage.image = UIImage(named: templateData[indexPath.row])
        cell.layer.shadowRadius = 8
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = .zero
        
        
        return cell
    }
    
    
}
