//
//  TabBarVC.swift
//  PrographyAssignment
//
//  Created by 신정욱 on 2/20/25.
//

import UIKit

import RxSwift
import RxCocoa

final class TabBarVC: UITabBarController {
    
    // MARK: Properties
    
    private let bag = DisposeBag()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setBinding()
    }
    
    // MARK: Configure Tab Bar
    
    private func configure() {
        // 뷰 추가
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: MyVC())

        // 탭바 이름 설정
        vc1.title = String(localized: "HOME")
        vc2.title = String(localized: "MY")
        
        // 이 시점에 탭바 아이템이 만들어짐
        setViewControllers([vc1, vc2], animated: true)

        // 탭바 이미지 설정, setViewControllers()호출 뒤에 설정해야만 함
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(named: "house")?.resizeImage(newWidth: 24)
        items[1].image = UIImage(named: "star_fill")?.resizeImage(newWidth: 24)

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // 그림자 제거
        appearance.backgroundColor = UIColor(hex: 0xF2F2F7)
        
        // 탭바 텍스트 색상
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.brandColor]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.onSurfaceVariant]
        // 탭바 아이콘 색상
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.brandColor
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.black
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: Binding
    
    private func setBinding() {
        // 탭을 선택할 때 햅틱 피드백 발생
        self.rx.didSelect
            .bind { _ in HapticManager.shared.occurLight() }
            .disposed(by: bag)
    }
}

#Preview {
    TabBarVC()
}
