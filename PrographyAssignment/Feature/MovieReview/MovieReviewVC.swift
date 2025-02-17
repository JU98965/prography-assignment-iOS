//
//  MovieReviewVC.swift
//  PrographyAssignment
//
//  Created by 신정욱 on 2/17/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class MovieReviewVC: UIViewController {
    
    // MARK: Components
    
    private let overallVStack = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private let productInfoCardView = PosterCardView()
    
    private let starLineView = StarLineView()
    
    private let detailsView = DetailsView()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setNavigationBar(titleImage: UIImage(named: "prography_logo"))
        setAutoLayout()
    }
    
    // MARK: Layout
    
    private func setAutoLayout() {
        view.addSubview(overallVStack)
        overallVStack.addArrangedSubview(productInfoCardView)
        overallVStack.addArrangedSubview(starLineView)
        overallVStack.addArrangedSubview(detailsView)
        
        overallVStack.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        productInfoCardView.snp.makeConstraints { $0.height.equalTo(247) }
        starLineView.snp.makeConstraints { $0.height.equalTo(60) }
    }

}

#Preview {
    UINavigationController(rootViewController: MovieReviewVC())
}
