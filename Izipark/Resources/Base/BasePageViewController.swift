//
//  BasePageViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 10/03/2023.
//

import UIKit

class BasePageViewController: UIPageViewController {
    
    // MARK: - Attributes -
    private (set) var page = 0
    private let pageViewControllers: [UIViewController]
    private let swipeEnabled: Bool
    weak var basePageDelegate: BasePageViewControllerDelegate?
    
    var isFirstPage: Bool {
        page == 0
    }
    
    var isLastPage: Bool {
        page == pageViewControllers.count - 1
    }
    
    // MARL: - Init -
    init(viewControllers: [UIViewController], delegate: BasePageViewControllerDelegate? = nil, swipeEnabled: Bool = false) {
        self.basePageDelegate = delegate
        self.pageViewControllers = viewControllers
        self.swipeEnabled = swipeEnabled
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        for (i,_) in pageViewControllers.enumerated() {
            pageViewControllers[i].view.tag = i
        }
        
        self.delegate = self
        self.dataSource = swipeEnabled ? self : nil
        
        if let initialViewController = pageViewControllers.first {
            self.setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions -
    func setPage(_ newPage: Int) {
        let viewController = pageViewControllers[newPage]
               
        setViewControllers([viewController], direction: page < newPage ? .forward : .reverse, animated: true, completion: nil)
        
        page = newPage
    }
    
    func nextPage() {
        let newPage = page + 1
        if newPage < pageViewControllers.count {
            setPage(newPage)
        }
    }
    
    func previousPage() {
        let newPage = page - 1
        if newPage >= 0  {
            setPage(newPage)
        }
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource -
extension BasePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let tag = viewController.view.tag - 1
        guard tag >= 0 else { return nil }
        return pageViewControllers[tag]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let tag = viewController.view.tag + 1
        guard pageViewControllers.count > tag else { return nil }
        return pageViewControllers[tag]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewController = pageViewController.viewControllers?.first {
            page = viewController.view.tag
            basePageDelegate?.pageDidChange(page)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let viewController = pendingViewControllers.first {
            page = viewController.view.tag
            basePageDelegate?.pageWillChange(page)
        }
    }
}

protocol BasePageViewControllerDelegate: AnyObject {
    func pageDidChange(_ page: Int)
    func pageWillChange(_ page: Int)
}

extension BasePageViewControllerDelegate {
    func pageDidChange(_ page: Int) { }
    func pageWillChange(_ page: Int) { }
}
