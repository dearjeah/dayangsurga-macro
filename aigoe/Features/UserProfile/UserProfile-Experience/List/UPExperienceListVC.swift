//
//  UPExperienceListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPExperienceListVC: MVVMViewController<UPExperienceListViewModel> {

    @IBOutlet weak var experienceListView: ExperiencePageView!
    
    var exp = [Experience]()
    var expViewModel = ExpertListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPExperienceListViewModel()
        setup()
        getInitialData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInitialData()
        experienceListView.getAndReload()
        //add func show Top Add
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUPExpForm" {
            let vc = segue.destination as? UPExperiecenFormVC
            //add dataFrom
        }
    }
    
    //function add Button
    
    @IBAction func unwindToUPExpList(_ unwindSegue: UIStoryboardSegue){
    }
    
}

//MARK: Initial setup
extension UPExperienceListVC{
    func setup(){
        self.title = "Experience"
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = backButton
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToExpForm(sender:)))
        showAddBtn()
    }
    
    func showAddBtn(){
        if exp.isEmpty{
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            //button is hidden = false
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryBlue
        }
    }
    
    @objc func goToExpForm(sender: UIBarButtonItem){
        performSegue(withIdentifier: "goToUPExpForm", sender: self)
    }
}

//MARK: Core Data
extension UPExperienceListVC{
    func getInitialData(){
        exp = self.viewModel.getAllExperience() ?? []
    }
}
