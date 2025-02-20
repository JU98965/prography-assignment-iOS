//
//  FilterButton.swift
//  PrographyAssignment
//
//  Created by 신정욱 on 2/19/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class FilterButton: UIView {
    
    // MARK: Properties
    
    private let bag = DisposeBag()
    
    // MARK: Components
    
    fileprivate let button = {
        let button = UIButton(configuration: .plain())
        button.layer.borderColor = UIColor.brandColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    // All과 별 심볼들을 한 배열에 담기 (UIView로 업캐스팅)
    fileprivate var symbolViews: [UIView] = {
        let label = UILabel()
        label.text = "All"
        label.textColor = .black
        label.font = .pretendardBold16
        label.isUserInteractionEnabled = false
        
        let views = (0...5)
            .map { StarsView(rate: $0) }
            .map {
                $0.isHidden = true
                $0.isUserInteractionEnabled = false
                return $0
            }
        
        return views + [label]
    }()
    
    private let listImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "list")?.resizeImage(newWidth: 24)
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = false
        return iv
    }()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func setAutoLayout() {
        self.addSubview(button)
        symbolViews.forEach { button.addSubview($0) }
        button.addSubview(listImageView)
        
        button.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
        symbolViews.forEach { $0.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        } }
        listImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(28)
        }
    }
    
    // MARK: Binding
    
    private func setBinding() {
        // 버튼이 하이라이트 됐을 때 반투명 효과를 주기
        button.rx.methodInvoked(#selector(setter: button.isHighlighted))
            .compactMap { $0.first as? Bool }
            .distinctUntilChanged()
            .bind(with: self) {
                $0.button.backgroundColor = $1 ? UIColor(hex: 0xF2F2F7) : .white
            }
            .disposed(by: bag)
    }
}

#Preview(traits: .fixedLayout(width: 412, height: 96)) {
    FilterButton()
}

// MARK: - Reactive

extension Reactive where Base: FilterButton {
    // 선택된 옵션의 심볼만 표시
    var selectedFilterIndex: Binder<Int> {
        Binder(base) { base, filterIdx in
            base.symbolViews.enumerated().forEach { index, view in
                view.isHiddenWithAnime = !(index == filterIdx)
            }
        }
    }
    
    var tapEvent: Observable<Void> {
        base.button.rx.tap.asObservable()
    }
}
