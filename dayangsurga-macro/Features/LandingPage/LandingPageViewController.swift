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
        collectionView.register(EmptyCell.nib(), forCellWithReuseIdentifier: EmptyCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if totalData != 0 {
            return LandingPageViewModel.resumes.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if totalData != 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeCell.identifier, for: indexPath) as? ResumeCell else {
                return UICollectionViewCell()
            }
            cell.pastResumeImage.image = LandingPageViewModel.resumes[indexPath.row].image
            cell.pastResumeImage.layer.cornerRadius = 8
            cell.pastResumeImage.addShadow()
            
            // sementara dulu buat check shadow
            cell.pastResumeImage.tintColor = UIColor.primaryBlue
            cell.pastResumeImage.backgroundColor = UIColor.white
            // ---
            
            cell.resumeName.text = LandingPageViewModel.resumes[indexPath.row].name
            cell.resumeLatestDate.text = LandingPageViewModel.resumes[indexPath.row].date
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCell.identifier, for: indexPath) as? EmptyCell else {
                return UICollectionViewCell()
            }
            cell.emptyImage.image = EmptyPageViewModel.emptyState.emptyImage
            cell.emptyLabel.text = EmptyPageViewModel.emptyState.emptyName
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if totalData != 0 {
            return CGSize(width: 151, height: 230)
        } else {
            return CGSize(width: 304, height: 324)
        }
    }
    
    func spacingForCollectionView(){
        if totalData != 0 {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 11
            layout.minimumInteritemSpacing = 45
            self.collectionView?.collectionViewLayout = layout
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // go to preview/generate page
    }

}
