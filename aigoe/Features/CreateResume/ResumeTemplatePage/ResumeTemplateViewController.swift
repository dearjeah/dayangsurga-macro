//
//  ResumeTemplateViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ResumeTemplateViewController: MVVMViewController<ResumeTemplateViewModel> {

    var selectedTemplate = 0
    var template = [Resume_Template]()
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
        selectResumeButton.dsLongFilledPrimaryButton(withImage: false, text: "Use This Template")
        
        let screenSize = UIScreen.main.bounds.size
        let collectionViewWidth = floor(screenSize.width*cellWidthScale)
        let collectionViewHeight = floor(screenSize.height*cellHeightScale)
        let insetX = (view.bounds.width - collectionViewWidth)/2.0
        let layout = resumeTemplateCollection?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)
        resumeTemplateCollection.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Resume Template"
        self.navigationItem.backButtonTitle = "Template"
        
        self.viewModel = ResumeTemplateViewModel()
        template = self.viewModel?.getTemplate() ?? []
    }

    @IBAction func didTapButton(_ sender: Any) {
        let userResume = createUserResume(selectedTemplate: selectedTemplate)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        navigate(userResume: userResume)
    }
    
    func navigate(userResume: User_Resume) {
        let storyboard = UIStoryboard(name: "StepByStepGuideViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToStepByStep") as! StepByStepGuideViewController
        vc.selectedTemplate = selectedTemplate
        vc.isCreate = true
        vc.selectedUserResume = userResume
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createUserResume(selectedTemplate: Int) -> User_Resume {
        let id = self.viewModel?.createResumeContent()
        if id != "" {
            self.viewModel?.createUserResume(resumeId: id ?? "abc000", selectedTemplate: selectedTemplate)
            guard let userResume = self.viewModel?.userResume.getUserResumeById(resume_id: id ?? "") else { return User_Resume() }
            return userResume
        }
        return User_Resume()
    }

}

extension ResumeTemplateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return template.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resumeTemplateCollection.dequeueReusableCell(withReuseIdentifier: "ResumeTemplateCell", for: indexPath)as! ResumeTemplateCell
        
        let image = UIImage(data: template[indexPath.row].image ?? Data())
        cell.resumeTemplateImage.image = image
        cell.layer.borderColor = UIColor.primaryDisable.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 18
        
        if indexPath.row == 0 && currentPage == 0{
            cell.layer.borderColor = UIColor.primaryBlue.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 18
        }
        
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      
        let layout = self.resumeTemplateCollection?.collectionViewLayout as! UICollectionViewFlowLayout
        let widthWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/widthWithSpacing
        
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * widthWithSpacing - scrollView.contentInset.left,  y: scrollView.contentInset.top)
        
        
        currentPage = Int(roundedIndex)
        resumeTemplatePageController.currentPage = currentPage % 3
        selectedTemplate = currentPage % 3
        let currentIndex = IndexPath(item: currentPage, section: 0)
        
        
        for i in 0...template.count{
            if i == currentPage{
                let cell = self.resumeTemplateCollection.cellForItem(at: currentIndex)
                cell?.layer.borderColor = UIColor.primaryBlue.cgColor
                cell?.layer.borderWidth = 2
                cell?.layer.cornerRadius = 18
            }else{
                let currentPage = IndexPath(item: i, section: 0)
                let cell = self.resumeTemplateCollection.cellForItem(at: currentPage)
                cell?.layer.borderColor = UIColor.primaryDisable.cgColor
                cell?.layer.cornerRadius = 18
            }
            
        }
        targetContentOffset.pointee = offset
    }
        
}
