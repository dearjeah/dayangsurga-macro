//
//  StepByStepGuidePageController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 27/10/21.
//

import UIKit

protocol StepByStepGuideDelegate: AnyObject {
    func progressBarUpdate(index: Int, totalData: Int)
    func goToGenerate(was: Bool)
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
    var personalData = User()
    var eduData = Education()
    var expData = Experience()
    var skillData = Skills()
    var accomData = Accomplishment()
    
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
extension StepByStepGuidePageController: PersonalInfoPageDelegate, QuizPageDelegate {
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
        buttonFunctional(currentPage: currentPageIndex)
        stepDelegate?.progressBarUpdate(index: currentPageIndex, totalData: stepControllerArr?.count ?? 0)
    }
    
    func goToPrev(wasPage: Int){
        guard let currentViewController = stepControllerArr?[wasPage] else { return }
        guard let prevViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([prevViewController], direction: .reverse, animated: true, completion: nil)
        setPageIndex(value: -1)
        hideUnHideButton(currentPage: currentPageIndex)
        buttonFunctional(currentPage: currentPageIndex)
        stepDelegate?.progressBarUpdate(index: currentPageIndex, totalData: stepControllerArr?.count ?? 0)
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
    
    func addAndEditData(isAdd: Bool){
        
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
    
    func isAddEdit(data: Int, pageType: Int) {
        //page type : 1-6, 6 = quiz
        if pageType == 4 {
            if data == 0 {
                //button text = add
            } else {
                //button text = edit
            }
        }
    }
    
    func buttonFunctional(currentPage: Int) {
        if isLastPage(currentIndex: currentPage) {
            prevNextDelegate?.changeTitleToGenerate(was: true)
        } else {
            if currentPage == 0 {
                prevNextDelegate?.isButtonEnable(left: false , right: true)
            } else {
                prevNextDelegate?.isButtonEnable(left: true, right: true)
            }
        }
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
        prevNextDelegate?.isButtonEnable(left: false, right: true)
    }
    
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectNext), name: Notification.Name("goToNext"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectPrev), name: Notification.Name("goToPrev"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectGenerate), name: Notification.Name("goToGenerate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(progressBarTapped), name: Notification.Name("progressBarTapped"), object: nil)
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
            } /*else if value == 0 {
               //NEED UPDATE
               currentPageIndex = value
               nextPageIndex = value + 1
               previousPageIndex = stepControllerArr?.count ?? 1 - 1
               }*/
        }
    }
}


//MARK: Populate Data
extension StepByStepGuidePageController {
    func populateResumeData() {
        if !isCreate {
            let data = ResumeContentRepository.shared.getResumeContentById(resume_id: Int(selectedResume.resume_id))
            
            if data != nil {
                personalData = UserRepository.shared.getUserById(id: Int(selectedResume.user_id)) ?? User()
                eduData = EducationRepository.shared.getEducationById(educationId: Int(data?.edu_id ?? Int32())) ?? Education()
                expData = ExperienceRepository.shared.getExperienceById(experienceId: Int(data?.exp_id ?? Int32())) ?? Experience()
                skillData = SkillRepository.shared.getSkillsById(skillId: data?.skill_id ?? Int32()) ?? Skills()
                accomData = AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: Int(data?.accom_id ?? Int32())) ??  Accomplishment()
            }
        }
    }
}

extension StepByStepGuidePageController {
    fileprivate func initPersonalData(fullName: String, email: String, phone: String, location: String, summary: String) -> UIViewController {
        let controller = UIViewController()
        let tmp = PersonalInfoPage.init(fullName: fullName, email: email, phone: phone, location: location, summary: summary)
        tmp.setup(dlgt: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initEducation() -> UIViewController {
        let controller = UIViewController()
        let tmp =  EducationPageView.init(text: "")
        //tmp.setup(delegate: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initQuiz(type: Int) -> UIViewController {
        let controller = UIViewController()
        let tmp = QuizPage.init(type: type)
        tmp.quizPageSetup(dlgt: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initExperience() -> UIViewController {
        let controller = UIViewController()
        let tmp = ExperiencePageView.init(text: "")
        //tmp.setup(delegate: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initSkills() -> UIViewController {
        let controller = UIViewController()
        let tmp = SkillsPageView.init(text: "")
        //tmp.setup(delegate: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func initAccomplishment() -> UIViewController {
        let controller = UIViewController()
        let tmp = AccomplishmentPageView.init(text: "")
        //tmp.setup(delegate: self)
        controller.view = tmp
        return controller
    }
    
    fileprivate func populateItems() {
        //page type : 1-6, 6 = quiz
        let personalInfo = initPersonalData(fullName: "", email: "", phone: "", location: "", summary: "")
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
