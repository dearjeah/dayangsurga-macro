//
//  StepByStepGuidePageController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 27/10/21.
//

import UIKit
import CloudKit

protocol StepByStepGuideDelegate: AnyObject {
    func progressBarUpdate(index: Int, totalData: Int)
    func goToGenerate(was: Bool)
    func goToAddExp(was: Bool, from: String)
    func goToEditExp(was: Bool, from: String, exp: Experience)
    func goToAddEdu(was: Bool, from: String)
    func goToEditEdu(was: Bool, from: String, edu: Education)
    func goToAddAccom(from: String)
    func goToEditAccom(from: String, accomp: Accomplishment)
    func personalInfoUpdate(data: PersonalInfo)
    func goToAddSkill(from: String)
    func goToEditSkill(from: String, skills: [Skills])
    func updateData(page: Int)
    func updateTableChecklist(from: String, id: String, isSelected: Bool)
    func goToPersonalInfoForm(from: String, personalInfo: Personal_Info)
}

protocol prevNextButtonDelegate: AnyObject {
    func isHidePrevNextButton(was: Bool)
    func changeTitleToGenerate(was: Bool)
    func isButtonEnable(left: Bool, right: Bool)
}

class StepByStepGuidePageController: UIPageViewController {

    var stepControllerArr: [UIViewController]? = []
    var isCreate: Bool = true //false = edit resume
    var currentPageIndex: Int = 0
    var nextPageIndex: Int = 1
    var previousPageIndex: Int = -1
    var quizAnswer: [Bool] = []
    var pageType: [Int] = []
    var selectedResume = User_Resume()
    var personalData = [Personal_Info]()
    var eduData = [Education]()
    var expData = [Experience]()
    var skillData = [Skills]()
    var accomData = [Accomplishment]()
    var currentResumeContent = Resume_Content()
    var currentUserId = ""
    
    weak var stepDelegate: StepByStepGuideDelegate?
    weak var prevNextDelegate: prevNextButtonDelegate?
    
    func stepSetup(stepDlgt: StepByStepGuideDelegate) {
        self.stepDelegate = stepDlgt
    }
    
    func prevNextSetup (prevNextDlgt: prevNextButtonDelegate) {
        self.prevNextDelegate = prevNextDlgt
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        self.isPagingEnabled = false
        
        populateResumeData()
        populateItems()
        style()
        setup()
        notificationCenterSetup()
    }
}

//MARK: Protocol Delegate
extension StepByStepGuidePageController: PersonalInfoPageDelegate, QuizPageDelegate, SmallSetButtonDelegate {
    func isAllTextfieldFilled(was: Bool, data: PersonalInfo) {
        if currentPageIndex == 0 {
            prevNextDelegate?.isButtonEnable(left: false, right: true)
            stepDelegate?.personalInfoUpdate(data: data)
        } else {
            prevNextDelegate?.isButtonEnable(left: true, right: true)
        }
    }
    
    func setPlaceHolder(fullName: String) {
        
    }
    
    //MARK: Notification Center
    @objc func didSelectNext() {
        goToNext(wasPage: currentPageIndex)
    }
    
    @objc func didSelectPrev() {
        goToPrev(wasPage: currentPageIndex)
    }
    
    @objc func didSelectGenerate() {
        goToGenerate()
    }
    
    @objc func progressBarTapped(_ notification: Notification) {
        var selectedPage = 0
        if let data = notification.userInfo as? [String: Int] {
            for (name, page) in data {
                print("\(name) : \(page) selected")
                selectedPage = page
            }
        }
        if selectedPage - 1 != currentPageIndex {
            goToDirectPage(selectedPageIndex: selectedPage)
        }
    }
    
    @objc func dataUpdate() {
        reloadData()
        buttonFunctional(currentPage: currentPageIndex)
    }
    
    @objc func clearStep() {
       currentPageIndex = 0
    }
    
    //MARK: Delegate Function
    func hideUnHideButton(currentPage: Int) {
        let isQuizPage = isQuizPage(currentIndex: currentPage)
        if isQuizPage {
            prevNextDelegate?.isHidePrevNextButton(was: true)
        } else {
            prevNextDelegate?.isHidePrevNextButton(was: false)
        }
    }
    
    //quizPagedelegate
    func quizAnswer(was: Bool) {
        let wasPage = currentPageIndex
        if was {
            goToNext(wasPage: wasPage)
        } else {
            if nextPageIndex != 7 {
                goToNext(wasPage: wasPage, addedValue: 1)
            } else {
                goToGenerate()
            }
        }
    }
    //for Quiz
    func didTapNext() {
        //
    }
    
    func didTapGenerate() {
        //
    }
    
    func didTapLeftButton() {
        quizAnswer(was: false)
    }
    
    func didTapRightButton() {
        quizAnswer(was: true)
    }
}

//MARK: Personal Info List Delegate
extension StepByStepGuidePageController: PersonalInfoListDelegate {
    func goToPersonalInfoForm(from: String, data: Personal_Info) {
        stepDelegate?.goToPersonalInfoForm(from: from, personalInfo: data)
    }
}

//MARK: Education List Delegate
extension StepByStepGuidePageController: ListEduDelegate {
    func addEduForm(from: String) {
        stepDelegate?.goToAddEdu(was: true, from: "add")
    }
    
    func editEduForm(from: String, edu: Education) {
        stepDelegate?.goToEditEdu(was: true, from: "edit", edu: edu)
    }
    
    func selectButtonEdu(eduId: String, isSelected: Bool) {
        stepDelegate?.updateTableChecklist(from: "edu", id: eduId, isSelected: isSelected)
        dataUpdate()
    }
}


//MARK: Experience List Delegate
extension StepByStepGuidePageController: ExperienceListDelegate {
    func goToAddExp() {
        stepDelegate?.goToAddExp(was: true, from: "add")
    }
    
    func passingExpData(exp: Experience?) {
        stepDelegate?.goToEditExp(was: true, from: "edit", exp: exp ?? Experience())
    }
    
    func selectButtonExp(expId: String, isSelected: Bool) {
        stepDelegate?.updateTableChecklist(from: "exp", id: expId, isSelected: isSelected)
        dataUpdate()
    }
}

//MARK: Skills List Delegate
extension StepByStepGuidePageController: skillListDelegate {
    func passDataFromEdit(from: String) {
        if from == "Add" {
            stepDelegate?.goToAddSkill(from: from)
        } else {
            stepDelegate?.goToEditSkill(from: from, skills: skillData)
        }
    }
    
    func selectButtonSkill(skillId: String, isSelected: Bool) {
        stepDelegate?.updateTableChecklist(from: "skill", id: skillId, isSelected: isSelected)
        dataUpdate()
    }
}

//MARK: Accomplishment List Delegate
extension StepByStepGuidePageController: AccomplishListDelegate {
    func goToAddAccom() {
        stepDelegate?.goToAddAccom(from: "add")
    }
    
    func passingAccomplishData(accomplish: Accomplishment?) {
        stepDelegate?.goToEditAccom(from: "edit", accomp: accomplish ?? Accomplishment())
    }
    
    func selectButtonAccom(accomId: String, isSelected: Bool) {
        stepDelegate?.updateTableChecklist(from: "accomp", id: accomId, isSelected: isSelected)
        dataUpdate()
    }
}

//MARK: Page Controller
extension StepByStepGuidePageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = stepControllerArr?.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return stepControllerArr?.last
        }
        guard stepControllerArr?.count ?? 0 > previousIndex else {
            return nil
        }
        return stepControllerArr?[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = stepControllerArr?.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard stepControllerArr?.count != nextIndex else {
            return stepControllerArr?.first
        }
        guard stepControllerArr?.count ?? 0 > nextIndex else {
            return nil
        }
        return stepControllerArr?[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return stepControllerArr?.count ?? 0
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = stepControllerArr?.firstIndex(of: firstViewController) else {
                  return 0
              }
        return firstViewControllerIndex
    }
}

//MARK: Page Controller Navigation
extension StepByStepGuidePageController {
    func goToNext(wasPage: Int, addedValue: Int? = 0){
        let addedValue = addedValue ?? 0
        guard let currentViewController = stepControllerArr?[wasPage + addedValue] else { return }
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        setPageIndex(value: 1 + addedValue)
        hideUnHideButton(currentPage: currentPageIndex)
        stepDelegate?.progressBarUpdate(index: currentPageIndex, totalData: stepControllerArr?.count ?? 0)
        stepDelegate?.updateData(page: currentPageIndex)
        reloadData()
        buttonFunctional(currentPage: currentPageIndex)
    }
    
    func goToPrev(wasPage: Int){
        guard let currentViewController = stepControllerArr?[wasPage] else { return }
        guard let prevViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([prevViewController], direction: .reverse, animated: true, completion: nil)
        setPageIndex(value: -1)
        hideUnHideButton(currentPage: currentPageIndex)
        stepDelegate?.progressBarUpdate(index: currentPageIndex, totalData: stepControllerArr?.count ?? 0)
        stepDelegate?.updateData(page: currentPageIndex)
        reloadData()
        buttonFunctional(currentPage: currentPageIndex)
    }
    
    func goToDirectPage(selectedPageIndex: Int){
        guard let selectedVC = stepControllerArr?[selectedPageIndex] else { return }
        guard let currentVC = dataSource?.pageViewController( self, viewControllerBefore: selectedVC) else { return }
        if selectedPageIndex > currentPageIndex {
            setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
        } else if selectedPageIndex < currentPageIndex {
            setViewControllers([currentVC], direction: .reverse, animated: true, completion: nil)
        }
        setPageIndex(value: selectedPageIndex - 1, progressBar: true)
    }
    
    func goToGenerate(){
        stepDelegate?.goToGenerate(was: true)
    }
}

//MARK: Checker
extension StepByStepGuidePageController {
    func isQuizPage(currentIndex: Int) -> Bool {
        if currentIndex < stepControllerArr?.count ?? 0 {
            if pageType[currentIndex] == 6 {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    
    func isLastPage(currentIndex: Int) -> Bool {
        let totalPage = stepControllerArr?.count ?? 0
        if currentIndex == totalPage - 1 {
            return true
        } else {
            return false
        }
    }
    
    func buttonFunctional(currentPage: Int) {
        if isLastPage(currentIndex: currentPage) {
            prevNextDelegate?.changeTitleToGenerate(was: true)
        } else {
            if currentPage == 0 {
                if personalData.count != 0 {
                    prevNextDelegate?.isButtonEnable(left: false , right: true)
                } else {
                    prevNextDelegate?.isButtonEnable(left: false , right: false)
                }
            } else {
                if pageType[currentPage] != 6 {
                    if pageType[currentPage] == 1 {
                        if currentResumeContent.personalInfo_id == nil || currentResumeContent.personalInfo_id?.count == 0{
                            prevNextDelegate?.isButtonEnable(left: false , right: false)
                        } else {
                            prevNextDelegate?.isButtonEnable(left: false , right: true)
                        }
                    } else if pageType[currentPage] == 2 {
                        //if eduData.isEmpty {
                       if currentResumeContent.edu_id == nil || currentResumeContent.edu_id?.count == 0 {
                            prevNextDelegate?.isButtonEnable(left: true , right: false)
                        } else {
                            prevNextDelegate?.isButtonEnable(left: true , right: true)
                        }
                    } else if pageType[currentPage] == 3 {
                        //if expData.isEmpty {
                        if currentResumeContent.exp_id == nil || currentResumeContent.exp_id?.count  == 0 {
                            prevNextDelegate?.isButtonEnable(left: true , right: false)
                        } else {
                            prevNextDelegate?.isButtonEnable(left: true , right: true)
                        }
                    } else if pageType[currentPage] == 4 {
                        //if skillData.isEmpty {
                        if currentResumeContent.skill_id == nil || currentResumeContent.skill_id?.count == 0 {
                            prevNextDelegate?.isButtonEnable(left: true , right: false)
                        } else {
                            prevNextDelegate?.isButtonEnable(left: true , right: true)
                        }
                    } else if pageType[currentPage] == 5 {
                        //if accomData.isEmpty {
                        if currentResumeContent.accom_id == nil || currentResumeContent.accom_id?.count == 0 {
                            prevNextDelegate?.isButtonEnable(left: true , right: false)
                        } else {
                            prevNextDelegate?.isButtonEnable(left: true , right: true)
                        }
                    } else {
                        prevNextDelegate?.isButtonEnable(left: true, right: true)
                    }
                } else if pageType[currentPage] == 6{
                    prevNextDelegate?.isButtonEnable(left: true , right: true)
                }
            }
        }
    }
    
    func dataExpChecker(data: [Experience]) -> Bool {
        for i in 0...data.count - 1 {
            if data[i].isSelected == true {
                return true
            }
        }
        return false
    }
    
    func dataEduChecker(data: [Education]) -> Bool {
        for i in 0...data.count - 1 {
            if data[i].is_selected == true {
                return true
            }
        }
        return false
    }
    
    func dataSkillsChecker(data: [Skills]) -> Bool {
        for i in 0...data.count - 1 {
            if data[i].is_selected == true {
                return true
            }
        }
        return false
    }
    
    func dataAccomChecker(data: [Accomplishment]) -> Bool {
        for i in 0...data.count - 1 {
            if data[i].is_selected == true {
                return true
            }
        }
        return false
    }
    
    func reloadData() {
        personalData = PersonalInfoRepository.shared.getAllPersonalInfo() ?? []
        eduData = EducationRepository.shared.getAllEducation() ?? []
        expData = ExperienceRepository.shared.getAllExperience() ?? []
        skillData = SkillRepository.shared.getAllSkill() ?? []
        accomData = AccomplishmentRepository.shared.getAllAccomplishment() ?? []
    }
}

//MARK: Style and Setup
extension StepByStepGuidePageController {
    func style() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [StepByStepGuidePageController.self])
        pc.currentPageIndicatorTintColor =  .clear
        pc.pageIndicatorTintColor = .clear
    }
    
    func setup() {
        if let firstViewController = stepControllerArr?.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        buttonFunctional(currentPage: currentPageIndex)
    }
    
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectNext), name: Notification.Name("goToNext"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectPrev), name: Notification.Name("goToPrev"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectGenerate), name: Notification.Name("goToGenerate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(progressBarTapped), name: Notification.Name("progressBarTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: Notification.Name("personalInfoReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: Notification.Name("eduReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: Notification.Name("expReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: Notification.Name("skillReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: Notification.Name("accompReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearStep), name: Notification.Name("clearStep"), object: nil)
    }
    
    private func setPageIndex(value: Int, progressBar: Bool = false) {
        //1: next page, -1: prev page
        if progressBar {
            //select using progress bar
            currentPageIndex = value
            nextPageIndex = value + 1
            previousPageIndex = value - 1
        } else {
            if value == 1 || value == -1 {
                //next or previous one time
                currentPageIndex = currentPageIndex + value
                nextPageIndex = nextPageIndex + value
                previousPageIndex = previousPageIndex + value
            } else if value == 2 {
                //quiz say no
                currentPageIndex = currentPageIndex + value
                nextPageIndex = nextPageIndex + value
                previousPageIndex = previousPageIndex + value
            } else if value == 0 {
               //NEED UPDATE
               currentPageIndex = value
               nextPageIndex = value + 1
               previousPageIndex = stepControllerArr?.count ?? 1 - 1
               }
        }
    }
}


//MARK: Populate Data
extension StepByStepGuidePageController {
    func populateResumeData() {
        if !isCreate {
            let data = ResumeContentRepository.shared.getResumeContentById(resume_id: selectedResume.resume_id ?? "")
            
            if data != nil {
                personalData = PersonalInfoRepository.shared.getAllPersonalInfo() ?? []
                //personalData = UserRepository.shared.getUserById(id: Int(selectedResume.user_id)) ?? User()
                currentResumeContent = data ?? Resume_Content()
            }
        }
    }
}

extension StepByStepGuidePageController {
    fileprivate func initPersonalData() -> UIViewController {
        let controller = MVVMViewController<PersonalInfoViewModel>()
        controller.viewModel =  PersonalInfoViewModel()
        personalData = controller.viewModel?.getAllPersonalInfoData() ?? []
        
        let tmp = PersonalInfoList.init(personalInfoData: personalData, resumeContent: currentResumeContent)
        tmp.setup(dlgt: self)
        controller.view = tmp
        return controller
        /*let controller = MVVMViewController<PersonalInfoViewModel>()
        controller.viewModel =  PersonalInfoViewModel()
        personalData = controller.viewModel?.getUserData() ?? User()
        
        let tmp = PersonalInfoPage.init(data: personalData, isCreate: isCreate)
        tmp.setup(dlgt: self)
        controller.view = tmp
        return controller*/
    }
    
    fileprivate func initEducation() -> UIViewController {
        let controller = MVVMViewController<EducationListViewModel>()
        controller.viewModel =  EducationListViewModel()
        eduData = controller.viewModel?.getEduData() ?? []
        
        let tmp =  EducationPageView.init(edu: eduData, resumeContent: currentResumeContent)
        tmp.setup(dlgt: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initQuiz(type: Int) -> UIViewController {
        let controller = UIViewController()
        let tmp = QuizPage.init(type: type)
        tmp.quizPageSetup(dlgt: self)
        tmp.yesNoSelection.delegate = self
        controller.view = tmp
        return controller
    }
    
    fileprivate func initExperience() -> UIViewController {
        let controller = MVVMViewController<ExperiencePageViewModel>()
        controller.viewModel = ExperiencePageViewModel()
        expData = controller.viewModel?.getAllExpData() ?? []
        
        let tmp = ExperiencePageView.init(exp: expData, resumeContent: currentResumeContent)
        tmp.setupExpList(dlgt: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initSkills() -> UIViewController {
        let controller = MVVMViewController<SkillsPageviewModel>()
        controller.viewModel = SkillsPageviewModel()
        skillData = controller.viewModel?.getAllSkillData() ?? []
        
        let tmp = SkillsPageView.init(skill: skillData, resumeContent: currentResumeContent)
        tmp.skillDelegateSetup(dlgt: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initAccomplishment() -> UIViewController {
        let controller = MVVMViewController<AccomplishmentPageViewModel>()
        controller.viewModel = AccomplishmentPageViewModel()
        accomData = controller.viewModel?.getAllAccomp() ?? []
        
        let tmp = AccomplishmentPageView.init(accom: accomData, resumeContent: currentResumeContent)
        tmp.setup(dlgt: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func populateItems() {
        //page type : 1-6, 6 = quiz
        let personalInfo = initPersonalData()
        let education = initEducation()
        let quiz = initQuiz(type: 1)
        let quiz2 = initQuiz(type: 2)
        let quiz3 = initQuiz(type: 3)
        let exp = initExperience()
        let skills = initSkills()
        let accomp = initAccomplishment()
        if isCreate {
            stepControllerArr?.append(contentsOf: [personalInfo, education, quiz, exp, quiz2, skills, quiz3, accomp])
            pageType.append(contentsOf:[1, 2, 6, 3, 6, 4, 6, 5])
        } else {
            stepControllerArr?.append(contentsOf: [personalInfo, education, exp, skills, accomp])
            pageType.append(contentsOf:[1, 2, 3, 4, 5])
        }
    }
    
}
