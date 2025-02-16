//
//  HomeVC.swift
//  PrographyAssignment
//
//  Created by 신정욱 on 2/13/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class HomeVC: UIViewController {
    
    // MARK: Properties
    
    private let homeVM = HomeVM()
    private let bag = DisposeBag()
    
    // MARK: Components
    
    private let overallVStack = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private let backdropCarouselView = BackdropCarouselView()
    
    private let tabContentsView = TabContentsView()
    
    private let pageTableVC = PageTableVC()
        
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationBar(titleImage: UIImage(named: "prography_logo"))
        setAutoLayout()
        setBinding()
    }
    
    // MARK: Layout
    
    private func setAutoLayout() {
        view.addSubview(overallVStack)
        overallVStack.addArrangedSubview(backdropCarouselView)
        overallVStack.addArrangedSubview(tabContentsView)
        overallVStack.addArrangedSubview(pageTableVC.view)
        
        overallVStack.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        backdropCarouselView.snp.makeConstraints { $0.height.equalTo(221) }
        tabContentsView.snp.makeConstraints { $0.height.equalTo(80) }
    }
    
    // MARK: Binding
    
    private func setBinding() {
        let changeIndex = Observable.merge(
            tabContentsView.rx.changeIndex,
            pageTableVC.rx.changeIndex
        )
        
        let input = HomeVM.Input(changeIndex: changeIndex)
        let output = homeVM.transform(input: input)

        // 선택된 인덱스 상태 업데이트
        output.selectedIndex
            .bind(to: tabContentsView.rx.selectedIndex, pageTableVC.rx.seletedIndex)
            .disposed(by: bag)
    }
}

#Preview {
    UINavigationController(rootViewController: HomeVC())
}
