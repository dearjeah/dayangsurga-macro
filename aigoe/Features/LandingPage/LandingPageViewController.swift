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
        emptyStateSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
        self.tabBarController?.tabBar.isHidden = false
        getInitialData()
        self.collectionView.reloadData()
    }

    @IBAction func buttonViewTapped(_ sender: Any) {
        didTapButton()
    }
}

//MARK: CRUD Code
extension LandingPageViewController {
    func getUserResumeContent(resumeId: String) -> Resume_Content {
        return self.viewModel?.getUserResumeContent(id: resumeId) ?? Resume_Content()
    }
    
    @objc func addResume(sender: UIBarButtonItem) {
        didTapButton()
    }
    
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

//MARK: Functional Code
extension LandingPageViewController {
    func showTopRightCreateResume() {
        if userResume.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
        }
    }

    func userResumeEmpty(was: Bool) {
        if was {
            emptyStateView.isHidden = false
            titleLabel.isHidden = true
            buttonView.isHidden = false
            self.collectionView.backgroundView = emptyStateView
        } else {
            emptyStateView.isHidden = true
            buttonView.isHidden = true
            titleLabel.isHidden = false
        }
    }
    
    func setIconImageForAlert(img: UIImage, x: Int, y: Int, width: Int, height: Int, isRed: Bool) -> UIImageView {
        let imgViewTitle = UIImageView(frame: CGRect(x: Int(self.view.frame.midX) + x, y: y, width: width, height: height))
        imgViewTitle.contentMode = .scaleAspectFit
        imgViewTitle.image = img
        if isRed {
            imgViewTitle.tintColor = UIColor.red
        }
        
        return imgViewTitle
    }
}

//MARK: Navigation
extension LandingPageViewController {
    func goToEdit(index: Int){
        let storyboard = UIStoryboard(name: "StepByStepGuideViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToStepByStep") as! StepByStepGuideViewController
        vc.selectedUserResume = userResume[selectedIndex]
        vc.selectedResumeContent = self.viewModel?.getUserResumeContent(id: userResume[selectedIndex].resume_id ?? "") ?? Resume_Content()
        vc.selectedTemplate = Int(userResume[selectedIndex].template_id)
        vc.isCreate = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToCheckTypo(){
        let storyboard = UIStoryboard(name: "CheckTypo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CheckTypoVC") as! CheckTypoVC
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToTranslateResume(){
        let storyboard = UIStoryboard(name: "TranslateResume", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TranslateResumeVC") as! TranslateResumeVC
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToPreview(){
        let storyboard = UIStoryboard(name: "PreviewResumeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPreviewResume") as! PreviewResumeViewController
        vc.selectedData = userResume[selectedIndex]
        let resumeContent = getUserResumeContent(resumeId: userResume[selectedIndex].resume_id ?? "" )
        let pdfCreator = PDFCreator(resumeContent: resumeContent, userResume: userResume[selectedIndex], selectedTemplate: Int(userResume[selectedIndex].template_id))
        vc.documentData = pdfCreator.createPDF()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
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
            userResumeEmpty(was: false)
        } else {
            userResumeEmpty(was: true)
        }
        return userResume.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeCell.identifier, for: indexPath) as? ResumeCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(data: userResume[indexPath.row].image ?? Data())
        cell.pastResumeImage.image = image
        cell.pastResumeImage.contentMode = .scaleToFill
        cell.resumeName.text = userResume[indexPath.row].name
        cell.resumeLatestDate.text = userResume[indexPath.row].lastUpdate?.string(format: Date.ISO8601Format.DayDateMonthYear)
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
        alert.addAction(UIAlertAction(title: "Check Typo", style: .default, handler: {action in self.goToCheckTypo()}))
        alert.addAction(UIAlertAction(title: "Translate Resume", style: .default, handler: {action in self.goToTranslateResume()}))
        alert.addAction(UIAlertAction(title: "Delete Resume", style: .destructive, handler: {action in self.showAlertForDelete()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor.primaryBlue
        
        let imgViewTitle1 = setIconImageForAlert(img:  UIImage.icDoc ?? UIImage(), x: 68, y: 62, width: 25, height: 25, isRed: false)
        let imgViewTitle2 = setIconImageForAlert(img:  UIImage.icPencil ?? UIImage(), x: 50, y: 115, width: 25, height: 25, isRed: false)
        let imgViewTitle3 = setIconImageForAlert(img:  UIImage.icTextCheck ?? UIImage(), x: 50, y: 175, width: 25, height: 25, isRed: false)
        let imgViewTitle4 = setIconImageForAlert(img:  UIImage.icRepeat ?? UIImage(), x: 75, y: 233, width: 25, height: 25, isRed: false)
        let imgViewTitle5 = setIconImageForAlert(img:  UIImage.icTrash ?? UIImage(), x: 60, y: 290, width: 25, height: 25, isRed: true)
        let imgViewTitle6 = setIconImageForAlert(img:  UIImage.icXmark ?? UIImage(), x: 28, y: 355, width: 25, height: 25, isRed: false)
        
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
    
    func alertViewSimple(title: String, message: String) {
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            controller.dismiss(animated: true, completion: nil)
        }))
        self.present(controller, animated: true, completion: nil)
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
    
    func getInitialData() {
        userResume = self.viewModel?.allUserResumeDataByDate() ?? []
        emptyState = self.viewModel?.getEmptyState()
        showTopRightCreateResume()
    }
    
    func emptyStateSetup() {
        let image = UIImage(data: emptyState?.image ?? Data())
        emptyStateView.emptyStateImage.image = image
        emptyStateView.emptyStateTitle.text = nil
        emptyStateView.emptyStateDescription.text = emptyState?.title
    }
}
