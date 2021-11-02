//
//  StepByStepGuidePageController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 27/10/21.
//

import UIKit

class StepByStepGuidePageController: UIPageViewController {
    
    var stepControllerArr: [UIViewController]? = []
    var currentPageIndex: Int = 0
    var nextPageIndex: Int = 1
    var previousPageIndex: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: Protocol Delegate
extension StepByStepGuidePageController {
    
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
    
    /*fileprivate func populateItems() {
     page type : 1-6, 6 = quiz
        for i in 0..<stepData.count{
            switch stepData[i].type {
            case 1:
                guard let progressImg = stepData[i].progressImg else {return}
                guard let stepImg = stepData[i].img else {return}
                guard let title = stepData[i].title else {return}
                guard let desc = stepData[i].longDesc else {return}
                let c = initBakingStepWithImageController(progressImg: progressImg, stepImg: stepImg, title: title, desc: desc)
                stepControllerArr?.append(c)
            case 2:
                guard let progressImg = stepData[i].progressImg else {return}
                guard let stepImg = stepData[i].img else {return}
                guard let stepVid = stepData[i].vid else {return}
                guard let title = stepData[i].title else {return}
                guard let desc = stepData[i].longDesc else {return}
                guard let mixingStat = stepData[i].mixingStatus else {return}
                guard let tech = stepData[i].tech else {return}
                let watch = recipe.isWatch
                let c = initBakingStepWithVideoController(progressImg: progressImg, stepImg: stepImg, stepVid: stepVid, title: title, desc: desc, tech: tech, mixingStat: mixingStat, isWatch: watch)
                stepControllerArr?.append(c)
            case 3:
                guard let progressImg = stepData[i].progressImg else {return}
                guard let title = stepData[i].title else {return}
                guard let desc = stepData[i].longDesc else {return}
                guard let time = stepData[i].bakingTime else {return}
                let c = initBakingStepWithTimerController(progressingImg: progressImg, title: title, desc: desc, time: time)
                stepControllerArr?.append(c)
            default:
                print("This is Finishing page")
            }
        }*/
}
