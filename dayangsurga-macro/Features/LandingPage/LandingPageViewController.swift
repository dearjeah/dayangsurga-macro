//
//  LandingPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class LandingPageViewController: MVVMViewController<LandingPageViewModel>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ResumeCellDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedIndex: Int = 0
    var userResume = [User_Resume]()
    var emptyState: Empty_State?
    var index = IndexPath()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        showButton()
        registerCollectionView()
        
        self.viewModel = LandingPageViewModel()
        userResume = self.viewModel?.allUserResumeDataByDate() ?? []
        emptyState = self.viewModel?.getEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
        self.tabBarController?.tabBar.isHidden = false
        self.collectionView.reloadData()
    }
    
    func setView(){
        self.title = "Resume"
        titleLabel.text = "My Resume"
    }
    
    func showButton() {
        let statusBarHeight =  navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? CGFloat()
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? CGFloat()
        let y = statusBarHeight + navigationBarHeight + 12
        let buttonView = BigButtonWithImage(frame: CGRect(x: 0, y: y, width: self.view.frame.width, height: 92))
        buttonView.delegate = self
        self.view.insertSubview(buttonView, at: 0)
    }
    
    func didTapButton() {
        let storyboard = UIStoryboard(name: "ResumeTemplateViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToTemplateResume") as! ResumeTemplateViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // setting for collection view
    func registerCollectionView(){
        collectionView.register(ResumeCell.nib(), forCellWithReuseIdentifier: ResumeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userResume.count != 0 {
            return userResume.count
        } else {
            let emptyStateView = EmptyState(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            let image = UIImage(data: emptyState?.image ?? Data())
            emptyStateView.emptyStateImage.image = image
            emptyStateView.emptyStateDescription.text = emptyState?.title
            self.collectionView.backgroundView = emptyStateView
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeCell.identifier, for: indexPath) as? ResumeCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(data: userResume[indexPath.row].image ?? Data())
        cell.pastResumeImage.image = image
        cell.pastResumeImage.contentMode = .scaleToFill
        cell.resumeName.text = userResume[indexPath.row].name
        cell.resumeLatestDate.text = userResume[indexPath.row].lastUpdate?.string(format: Date.ISO8601Format.DayMonthYear)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 230)
    }
    
    func spacingForCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 45
        self.collectionView?.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        index = indexPath
        createAlert()
    }
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    func createAlert(){
        let alert = UIAlertController(title: "\(userResume[selectedIndex].name ?? "")", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Preview Resume", style: .default, handler: {action in self.goToPreview()}))
        alert.addAction(UIAlertAction(title: "Edit Resume", style: .default, handler: {action in self.goToEdit(index: self.selectedIndex )}))
        alert.addAction(UIAlertAction(title: "Check Typo", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Translate Resume", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete Resume", style: .destructive, handler: {action in self.showAlertForDelete()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor.primaryBlue
        
        let img1 = UIImage(systemName: "doc.text")
        let imgViewTitle1 = UIImageView(frame: CGRect(x: self.view.frame.midX + 68, y: 62, width: 25, height: 25))
        imgViewTitle1.contentMode = .scaleAspectFit
        imgViewTitle1.image = img1
        
        let img2 = UIImage(systemName: "pencil")
        let imgViewTitle2 = UIImageView(frame: CGRect(x: self.view.frame.midX + 50, y: 115, width: 25, height: 25))
        imgViewTitle2.contentMode = .scaleAspectFit
        imgViewTitle2.image = img2
        
        let img3 = UIImage(systemName: "text.badge.checkmark")
        let imgViewTitle3 = UIImageView(frame: CGRect(x: self.view.frame.midX + 50, y: 175, width: 25, height: 25))
        imgViewTitle3.contentMode = .scaleAspectFit
        imgViewTitle3.image = img3
        
        let img4 = UIImage(systemName: "repeat")
        let imgViewTitle4 = UIImageView(frame: CGRect(x: self.view.frame.midX + 75, y: 233, width: 25, height: 25))
        imgViewTitle4.contentMode = .scaleAspectFit
        imgViewTitle4.image = img4
        
        let img5 = UIImage(systemName: "trash")
        let imgViewTitle5 = UIImageView(frame: CGRect(x: self.view.frame.midX + 60, y: 290, width: 25, height: 25))
        imgViewTitle5.contentMode = .scaleAspectFit
        imgViewTitle5.tintColor = UIColor.red
        imgViewTitle5.image = img5
        
        let img6 = UIImage(systemName: "xmark")
        let imgViewTitle6 = UIImageView(frame: CGRect(x: self.view.frame.midX + 28, y: 355, width: 25, height: 25))
        imgViewTitle6.contentMode = .scaleAspectFit
        imgViewTitle6.image = img6
        
        alert.view.addSubview(imgViewTitle1)
        alert.view.addSubview(imgViewTitle2)
        alert.view.addSubview(imgViewTitle3)
        alert.view.addSubview(imgViewTitle4)
        alert.view.addSubview(imgViewTitle5)
        alert.view.addSubview(imgViewTitle6)
        self.present(alert, animated: true)
    }
    
    func goToPreview(){
        let storyboard = UIStoryboard(name: "PreviewResumeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPreviewResume") as! PreviewResumeViewController
        // passing data
        vc.selectedData = userResume[selectedIndex]
        let dataInput = "Test"
        
        let pdfCreator = PDFCreator(
            dataInput: dataInput, userResume: userResume[selectedIndex]
        )
        
        vc.documentData = pdfCreator.createFlyer()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEdit(index: Int){
        let storyboard = UIStoryboard(name: "StepByStepGuideViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToStepByStep") as! StepByStepGuideViewController
        // passing data
//        vc.index = index
        vc.selectedData = userResume[selectedIndex]
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Delete Data?", message: "You will not be able to recover it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteResumeData()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // for delete and reload
    func deleteResumeData(){
        self.viewModel?.deleteResumeData(resume: self.userResume[self.selectedIndex])
        self.userResume.remove(at: selectedIndex)
        userResume = self.viewModel?.getUserResume() ?? []
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [index])
        })
        self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
        collectionView.reloadData()
    }

}
