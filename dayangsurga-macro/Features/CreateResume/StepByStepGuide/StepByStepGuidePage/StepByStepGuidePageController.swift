//
//  StepByStepGuidePageController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 27/10/21.
//

import UIKit

protocol StepByStepGuideDelegate: AnyObject {
    func progressBarUpdate(index: Int)
}

protocol prevNextButtonDelegate: AnyObject {
    func isHidePrevNextButton(was: Bool)
}

class StepByStepGuidePageController: UIPageViewController {
    
    var stepControllerArr: [UIViewController]? = []
    var isCreate: Bool = true //false = edit resume
    var currentPageIndex: Int = 0
    var nextPageIndex: Int = 1
    var previousPageIndex: Int = -1
    var quizAnswer: [Bool] = []
    var pageType: [Int] = []
    
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
        
        populateItems()
        style()
        setup()
        notificationCenterSetup()
    }
    
}

//MARK: Protocol Delegate
extension StepByStepGuidePageController: PersonalInfoPageDelegate {
    
    //MARK: Notification Center
    @objc func didSelectNext() {
        goToNext(wasPage: currentPageIndex)
    }
    
    @objc func didSelectPrev() {
        gotToPrev(wasPage: currentPageIndex)
    }
    
    @objc func didSelectGenerate() {
        goGenerate(wasPage: currentPageIndex)
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
            print("sadsakdaskdjsakjdksad", "selected:",selectedPage, "current:",currentPageIndex)
        }
    }
    
    //MARK: Delegate Function
    func hideUnHideButton(currentPage: Int) {
        if pageType[currentPage] == 6 {
            prevNextDelegate?.isHidePrevNextButton(was: true)
        } else {
            prevNextDelegate?.isHidePrevNextButton(was: false)
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
    func goToNext(wasPage: Int){
        guard let currentViewController = stepControllerArr?[wasPage] else { return }
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        setPageIndex(value: 1)
        hideUnHideButton(currentPage: currentPageIndex)
    }
    
    func gotToPrev(wasPage: Int){
        guard let currentViewController = stepControllerArr?[wasPage] else { return }
        guard let prevViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([prevViewController], direction: .reverse, animated: true, completion: nil)
        setPageIndex(value: -1)
        hideUnHideButton(currentPage: currentPageIndex)
    }
    
    func goToDirectPage(selectedPageIndex: Int){
        guard let selectedVC = stepControllerArr?[selectedPageIndex] else { return }
        guard let currentVC = dataSource?.pageViewController( self, viewControllerBefore: selectedVC) else { return }
        if selectedPageIndex > currentPageIndex {
            setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
        } else if selectedPageIndex < currentPageIndex {
            setViewControllers([currentVC], direction: .reverse, animated: true, completion: nil)
        }
        setPageIndex(value: selectedPageIndex-1)
        hideUnHideButton(currentPage: selectedPageIndex)
    }
    
    func goGenerate(wasPage: Int){
        self.navigationController?.pushViewController(GenerateResumeController.instantiateStoryboard(viewModel: GenerateResumeViewModel()), animated: true)
    }
    
    func addAndEditData(isAdd: Bool){
        
    }
}

//MARK: Checker
extension StepByStepGuidePageController {
    func isQuizPage(currentIndex: Int) -> Bool {
        if currentIndex == 3 || currentIndex == 5 || currentIndex == 7 {
            return true
        }
        else {
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
    }
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectNext), name: Notification.Name("goToNext"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectPrev), name: Notification.Name("goToPrev"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectGenerate), name: Notification.Name("goToGenerate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(progressBarTapped), name: Notification.Name("progressBarTapped"), object: nil)
    }
    
    private func setPageIndex(value: Int) {
        //1: next page, -1: prev page
        if value == 1 {
            currentPageIndex = currentPageIndex + value
            nextPageIndex = nextPageIndex + value
            previousPageIndex = previousPageIndex + value
        } else if value == -1 {
            currentPageIndex = currentPageIndex + value
            nextPageIndex = nextPageIndex + value
            previousPageIndex = previousPageIndex + value
        } else {
            //select using progress bar
            currentPageIndex = value
            nextPageIndex = value + 1
            previousPageIndex = value - 1
        }
    }
}


//MARK: Populate Data
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
        //tmp.setup(delegate: self)
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
        let source = "create"
        let personalInfo = initPersonalData(fullName: "", email: "", phone: "", location: "", summary: "")
        let education = initEducation()
        let quiz = initQuiz(type: 1)
        let quiz2 = initQuiz(type: 2)
        let quiz3 = initQuiz(type: 3)
        let exp = initExperience()
        let skills = initSkills()
        let accomp = initAccomplishment()
        if source == "create" {
            stepControllerArr?.append(contentsOf: [personalInfo, education, quiz, exp, quiz2, skills, quiz3, accomp])
            pageType.append(contentsOf:[1, 2, 6, 3, 6, 4, 6, 5])
        } else {
            stepControllerArr?.append(contentsOf: [personalInfo, education, exp, skills, accomp])
            pageType.append(contentsOf:[1, 2, 3, 4, 5])
        }
    }
    
}
