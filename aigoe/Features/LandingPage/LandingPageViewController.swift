//
//  LandingPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class LandingPageViewController: MVVMViewController<LandingPageViewModel> {
    
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyStateView: EmptyState!
    var selectedIndex: Int = 0
    var userResume = [User_Resume]()
    var emptyState: Empty_State?
    var index = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        registerCollectionView()
        navigationStyle()
        
        self.viewModel = LandingPageViewModel()
        getInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
        self.tabBarController?.tabBar.isHidden = false
        getInitialData()
        self.collectionView.reloadData()
    }
    
    func getInitialData() {
        userResume = self.viewModel?.allUserResumeDataByDate() ?? []
        emptyState = self.viewModel?.getEmptyState()
        showTopRightCreateResume()
    }
    
    func showTopRightCreateResume() {
        if userResume.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
        }
    }
    
    @IBAction func buttonViewTapped(_ sender: Any) {
        didTapButton()
    }
    
    @objc func addResume(sender: UIBarButtonItem) {
        didTapButton()
    }
    
    func getUserResumeContent(resumeId: String) -> Resume_Content {
        return self.viewModel?.getUserResumeContent(id: resumeId) ?? Resume_Content()
    }
    
    func goToPreview(){
        let storyboard = UIStoryboard(name: "PreviewResumeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPreviewResume") as! PreviewResumeViewController
        // passing data
        vc.selectedData = userResume[selectedIndex]
        let resumeContent = getUserResumeContent(resumeId: userResume[selectedIndex].resume_id ?? "" )
        
        let pdfCreator = PDFCreator(resumeContent: resumeContent, userResume: userResume[selectedIndex], selectedTemplate: 0)
        //
        vc.documentData = pdfCreator.createPDF()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
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
        showTopRightCreateResume()
        collectionView.reloadData()
    }
    
}

//MARK: Initial Setup
extension LandingPageViewController {
    func navigationStyle(){
        configureNavigationBar(largeTitleColor: .white, backgoundColor:UIColor.primaryBlue, tintColor: UIColor.white, title: "Resume", preferredLargeTitle: true, hideBackButton: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Resume", style: .plain, target: self, action: #selector(self.addResume(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
    }
    
    func setView(){
        self.title = "Resume"
        titleLabel.text = "Explore more feature by clicking your resume"
        buttonView.dsLongFilledPrimaryButton(withImage: false, text: "Create Resume")
    }
}

//MARK: Collection View
extension LandingPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func registerCollectionView(){
        collectionView.register(ResumeCell.nib(), forCellWithReuseIdentifier: ResumeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userResume.count != 0 {
            emptyStateView.isHidden = true
            buttonView.isHidden = true
            titleLabel.isHidden = false
            return userResume.count
        } else {
            emptyStateView.isHidden = false
            titleLabel.isHidden = true
            buttonView.isHidden = false
            let image = UIImage(data: emptyState?.image ?? Data())
            emptyStateView.emptyStateImage.image = image
            emptyStateView.emptyStateTitle.text = nil
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
        layout.minimumLineSpacing = 29
        layout.minimumInteritemSpacing = 45
        self.collectionView?.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        index = indexPath
        //goToPreview()
        createAlert()
    }
}

//MARK: Alert
extension LandingPageViewController {
    func createAlert(){
        let alert = UIAlertController(title: "\(userResume[selectedIndex].name ?? "")", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Preview Resume", style: .default, handler: {action in self.goToPreview()}))
        alert.addAction(UIAlertAction(title: "Edit Resume", style: .default, handler: {action in self.goToEdit(index: self.selectedIndex )}))
        alert.addAction(UIAlertAction(title: "Check Typo", style: .default, handler: {action in self.goToComingSoon()}))
        alert.addAction(UIAlertAction(title: "Translate Resume", style: .default, handler: {action in self.goToComingSoon()}))
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
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Delete Data?", message: "You will not be able to recover it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteResumeData()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToEdit(index: Int){
        let storyboard = UIStoryboard(name: "StepByStepGuideViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToStepByStep") as! StepByStepGuideViewController
        vc.selectedUserResume = userResume[selectedIndex]
        vc.isCreate = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToComingSoon(){
        let storyboard = UIStoryboard(name: "UserProfileViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserProfileView") as! UserProfileViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Delegate
extension LandingPageViewController: ResumeCellDelegate {
    func didTapButton() {
        let storyboard = UIStoryboard(name: "ResumeTemplateViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToTemplateResume") as! ResumeTemplateViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
