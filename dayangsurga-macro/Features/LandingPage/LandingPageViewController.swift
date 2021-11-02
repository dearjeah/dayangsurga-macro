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
    var totalData: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        showButton()
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
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
        if totalData != 0 {
            return LandingPageViewModel.resumes.count
        } else {
            let emptyStateView = EmptyState(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            emptyStateView.emptyStateImage.image = UIImage(named: "imgEmptyStateLandingPage")
            emptyStateView.emptyStateDescription.text = "You haven’t made any resume, yet. Click the ‘Create Resume’ button to start creating resume."
            self.collectionView.backgroundView = emptyStateView
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeCell.identifier, for: indexPath) as? ResumeCell else {
            return UICollectionViewCell()
        }
        cell.pastResumeImage.image = LandingPageViewModel.resumes[indexPath.row].image
        
        // sementara dulu buat check shadow
        cell.pastResumeImage.tintColor = UIColor.primaryBlue
        cell.pastResumeImage.backgroundColor = UIColor.white
        // ---
        
        cell.resumeName.text = LandingPageViewModel.resumes[indexPath.row].name
        cell.resumeLatestDate.text = LandingPageViewModel.resumes[indexPath.row].date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 230)
    }
    
    func spacingForCollectionView(){
        if totalData != 0 {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 45
            self.collectionView?.collectionViewLayout = layout
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        createAlert()
    }
    
    func createAlert(){
        let alert = UIAlertController(title: "resume name", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit Resume 􀈊", style: .default, handler: {action in self.goToEdit()}))
        alert.addAction(UIAlertAction(title: "Check Typo 􀋺", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Translate Resume 􀊞", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete Resume 􀈑", style: .destructive, handler: {action in self.showAlertForDelete()}))
        alert.addAction(UIAlertAction(title: "Cancel 􀆄", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func goToEdit(){
        let storyboard = UIStoryboard(name: "StepByStepGuideViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToStepByStep") as! StepByStepGuideViewController
        // blm passing data
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.titleView?.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Do you want to delete?", message: "...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
