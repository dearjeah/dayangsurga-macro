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
    var totalData: Int?
    
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
        totalData = 2
        if totalData == 0 {
            self.collectionView.setEmptyState(image: UIImage(systemName: "person.fill.xmark") ?? UIImage(), message: "You haven’t made any resume, yet. Click the ‘Create Resume’ button to start creating resume.")
        } else {
            return LandingPageViewModel.resumes.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeCell.identifier, for: indexPath) as? ResumeCell else {
            return UICollectionViewCell()
        }
        cell.pastResumeImage.image = LandingPageViewModel.resumes[indexPath.row].image
        cell.pastResumeImage.layer.cornerRadius = 8
        
        // sementara dulu buat check shadow
        cell.pastResumeImage.tintColor = UIColor.primaryBlue
        cell.pastResumeImage.backgroundColor = UIColor.primaryBG
        cell.pastResumeImage.dropShadow(color: UIColor.tertiaryLabel, opacity: 1, offSet: CGSize(width: 5, height: 3), radius: 1, scale: true)
        // ---
        
        cell.resumeName.text = LandingPageViewModel.resumes[indexPath.row].name
        cell.resumeLatestDate.text = LandingPageViewModel.resumes[indexPath.row].date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 230)
    }
    
    func spacingForCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 11
        layout.minimumInteritemSpacing = 45
        self.collectionView?.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // go to preview/generate page
    }

}

extension UICollectionView {
    func setEmptyState(image: UIImage, message: String) {
        let emptyImag = UIImageView(frame: CGRect(x: 63, y: 0, width: 252, height: 220))
//        let emptyImag = UIImageView(frame: UIScreen.main.bounds)
        emptyImag.translatesAutoresizingMaskIntoConstraints = false
        emptyImag.image = image
        emptyImag.contentMode = .scaleAspectFill
        
        let emptyMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyMessage.translatesAutoresizingMaskIntoConstraints = false
        emptyMessage.text = message
        emptyMessage.textColor = UIColor.tertiaryLabel
        emptyMessage.numberOfLines = 0
        emptyMessage.textAlignment = .center
        emptyMessage.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        emptyMessage.sizeToFit()
        
        self.insertSubview(emptyImag, at: 0)
        self.backgroundView = emptyMessage // maunya emptyimage msk ke background view juga
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

extension UIImageView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.cornerRadius = 8

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
