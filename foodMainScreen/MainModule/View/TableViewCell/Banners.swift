//
//  Banners.swift
//  test1
//
//  Created by Артем Макар on 5.04.23.
//
import SnapKit
import UIKit
final class BannersView: UIView {
    
    private var banners = [String]()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        collectionView.dataSource = self
        collectionView.register(BannersCell.self, forCellWithReuseIdentifier: BannersCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(bannersString: [String]) {
        banners = bannersString
        collectionView.reloadData()
        print(bannersString)
    }
    
    private func setupViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 112)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: createPromotionsView())
    }
    
    private func createPromotionsView()  -> NSCollectionLayoutSection {
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -8)
            
            let rowHeight = NSCollectionLayoutDimension.fractionalHeight(1)
            let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                 heightDimension: rowHeight)
            let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: row)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            
            
            return section
        }
}


extension BannersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(banners)
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: BannersCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannersCell.reuseID, for: indexPath) as? BannersCell else { return UICollectionViewCell()}
        
        print(banners)
        let banner = banners[indexPath.row]
        cell.configure(string: banner)
        
        return cell
    }
}

final class BannersCell: UICollectionViewCell {
    
    static let reuseID = "BannersCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "banner1")
        image.contentMode = .center
        image.contentMode = .scaleAspectFill
        //image.frame = CGRect(x: 0, y: 0, width: 300, height: 112)
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(string: String) {
        
        imageView.image = UIImage(named: string)
    }
    
    private func setupView() {
        
        backgroundColor = .systemBackground
        
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
