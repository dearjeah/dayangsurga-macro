//
//  ResumeTemplateViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ResumeTemplateViewController: MVVMViewController<ResumeTemplateViewModel> {

    var templateData = ["imgResumeTemplateArial","imgResumeTemplateGeorgia","imgResumeTemplateHeletvica"]
    var currentPage = 0
    let cellWidthScale = 0.71
    let cellHeightScale = 0.67
   
    @IBOutlet weak var resumeTemplateCollection: UICollectionView!
    @IBOutlet weak var resumeTemplatePageController: UIPageControl!
    @IBOutlet weak var selectResumeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resumeTemplateCollection.register(UINib.init(nibName: "ResumeTemplateCell", bundle: nil), forCellWithReuseIdentifier: "ResumeTemplateCell")
        selectResumeButton.dsLongFilledPrimaryButton(withImage: false, text: "Use Template")
        let screenSize = UIScreen.main.bounds.size
        let collectionViewWidth = floor(screenSize.width*cellWidthScale)
        print(collectionViewWidth)
        let collectionViewHeight = floor(screenSize.height*cellHeightScale)
        print(collectionViewHeight)
        let insetX = (view.bounds.width - collectionViewWidth)/2.0
        let layout = resumeTemplateCollection?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)
        resumeTemplateCollection.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
       
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
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.cornerRadius = 8
        
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      
        let layout = self.resumeTemplateCollection?.collectionViewLayout as! UICollectionViewFlowLayout
        let widthWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
        print(widthWithSpacing)
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/widthWithSpacing
        
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * widthWithSpacing - scrollView.contentInset.left,  y: scrollView.contentInset.top)
        
        currentPage = Int(roundedIndex)
        
        resumeTemplatePageController.currentPage = currentPage
        print(resumeTemplatePageController.currentPage)
        targetContentOffset.pointee = offset
        
        
    }
    
}
