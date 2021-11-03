//
//  StepByStepGuidePageController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 27/10/21.
//

import UIKit

class StepByStepGuidePageController: UIPageViewController {
    
    var stepControllerArr: [UIViewController]? = []
    var isCreate: Bool = true //false = edit resume
    var currentPageIndex: Int = 0
    var nextPageIndex: Int = 1
    var previousPageIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        populateItems()
        //style()
        setup()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: Protocol Delegate
extension StepByStepGuidePageController: PersonalInfoPageDelegate {
    
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
        guard let currentViewController = stepControllerArr?[currentPageIndex] else { return }
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        setPageIndex(value: 1)
    }
    
    func gotToPrev(wasPage: Int){
        guard let currentViewController = stepControllerArr?[currentPageIndex] else { return }
        guard let prevViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([prevViewController], direction: .reverse, animated: true, completion: nil)
        setPageIndex(value: -1)
    }
    
    func goGenerate(wasPage: Int){
        self.navigationController?.pushViewController(GenerateResumeController.instantiateStoryboard(viewModel: GenerateResumeViewModel()), animated: true)
        //self.navigationController?.pushViewController(MedaliDetailController.instantiateStoryboard(viewModel: MedaliDetailViewModel(datasVM: mdDatas)), animated: true)
    }
    
    func addAndEditData(isAdd: Bool){
        
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
    
    fileprivate func initQuiz() -> UIViewController {
        let controller = UIViewController()
        let tmp = QuizPage.init(header: "")
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
        let quiz = initQuiz()
        let quiz2 = initQuiz()
        let quiz3 = initQuiz()
        let exp = initExperience()
        let skills = initSkills()
        let accomp = initAccomplishment()
        if source == "create" {
            stepControllerArr?.append(personalInfo)
            stepControllerArr?.append(education)
            stepControllerArr?.append(quiz)
            stepControllerArr?.append(exp)
            stepControllerArr?.append(quiz2)
            stepControllerArr?.append(skills)
            stepControllerArr?.append(quiz3)
            stepControllerArr?.append(accomp)
        } else {
            stepControllerArr?.append(personalInfo)
            stepControllerArr?.append(education)
            stepControllerArr?.append(exp)
            stepControllerArr?.append(skills)
            stepControllerArr?.append(accomp)
        }
    }
    
}
