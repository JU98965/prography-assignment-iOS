//
//  PosterCardView.swift
//  PrographyAssignment
//
//  Created by 신정욱 on 2/17/25.
//

import UIKit

import Kingfisher
import RxSwift
import SnapKit

final class PosterCardView: UIView {
    
    // MARK: Components
    
    private let gradientView = PosterCardGradientView()
    
    fileprivate let posterImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func setAutoLayout() {
        self.addSubview(gradientView)
        self.addSubview(posterImageView)
        
        gradientView.snp.makeConstraints { $0.edges.equalToSuperview() }
        posterImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

#Preview {
    PosterCardView()
}

// MARK: - Reactive

extension Reactive where Base: PosterCardView {
    var posterPath: Binder<MovieDetail> {
        Binder(base) { base, detail in
            let url = URL(string: "https://image.tmdb.org/t/p/original"+detail.posterPath)
            Task { @MainActor in
                base.posterImageView.kf.indicatorType = .activity
                base.posterImageView.kf.setImage(with: url)
            }
        }
    }
}
