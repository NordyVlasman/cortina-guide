//
//  PageViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

protocol PageViewControllerDelegate: AnyObject {
    func pageViewController(_ pageViewController: PageViewController, didSwipeToPendingViewControllerAt index: Int)
}

final class PageViewController: UIPageViewController {
    
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    private var inProgress = false
    
    var pages: [UIViewController]? {
        didSet {
            guard let pages = pages, let initialViewController = pages.first else {
                return
            }
            
            setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    var isLastPage: Bool {
        guard let pages = pages else { return false }
        return pages.count - 1 == currentIndex
    }
    
    private(set) var currentIndex = 0 {
        didSet {
            pageViewControllerDelegate?.pageViewController(self, didSwipeToPendingViewControllerAt: currentIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        guard !inProgress else { return }
        inProgress = true
        
        super.setViewControllers(viewControllers, direction: direction, animated: animated) { completed in
            self.inProgress = false
            completion?(completed)
            
            if let view = viewControllers?.first?.view {
                UIAccessibility.post(notification: .screenChanged, argument: view)
            }
        }
    }
    
    func nextPage() {
        guard let currentViewController = viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        guard !inProgress else { return }
        currentIndex += 1
        setViewControllers([nextViewController], direction: .forward, animated: true)
    }
    
    func previousPage() {
        guard let currentViewController = viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        guard !inProgress else { return }
        currentIndex -= 1
        setViewControllers([previousViewController], direction: .reverse, animated: true)
    }
    
    func startAtIndex(_ index: Int) {
        guard let pages = pages, pages.count > index else {
            return
        }
        guard !inProgress else {
            return
        }
        setViewControllers([pages[index]], direction: .forward, animated: false, completion: nil)
        currentIndex = index
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pages = pages, let index = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let updatedIndex = index - 1
        guard updatedIndex >= 0 else {
            return nil
        }
        return pages[updatedIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pages = pages, let index = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let updatedIndex = index + 1
        guard updatedIndex < pages.count else {
            return nil
        }
        return pages[updatedIndex]
    }
    
    
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        guard let pages = pages, let currentViewController = viewControllers?.first, let index = pages.firstIndex(of: currentViewController) else { return }
        currentIndex = index
    }
}
