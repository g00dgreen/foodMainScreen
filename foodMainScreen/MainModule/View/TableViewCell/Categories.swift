//
//  Categories.swift
//  test1
//
//  Created by Артем Макар on 5.04.23.
//

import Foundation
import UIKit


protocol ScrollTableHeaderProtocol {
    func scrollHeader(item: Int)
}
final class CategoriesView: UITableViewHeaderFooterView, UICollectionViewDelegate, ScrollTableHeaderProtocol {
    
    var delegate: ScrollTableProtocol?
    private var categories: [String]
    private static var newIndex: IndexPath = IndexPath(item: 0, section: 0)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        collectionView.backgroundColor = .white

        
        return collectionView
    }()
    init(categories: [String]) {
        self.categories = categories
        super.init(reuseIdentifier: CategoryCell.reuseID)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: createButtonView())
    }
    
    private func createButtonView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let rowHeight = NSCollectionLayoutDimension.fractionalHeight(1)
        let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.26), heightDimension: rowHeight)
        
        let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: row)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
}


extension CategoriesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.titleLabel.text = categories[indexPath.row]
        if indexPath == CategoriesView.newIndex {
            let color = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
            cell.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
            cell.titleLabel.textColor = color
            cell.titleLabel.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        } else {
            cell.backgroundColor = .white
            cell.titleLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
            cell.titleLabel.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        }
        return cell
    }
    func scrollHeader(item: Int) {
        CategoriesView.newIndex = IndexPath(item: item-1, section: 0)
        collectionView.reloadData()
        collectionView.scrollToItem(at: CategoriesView.newIndex, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row+1)
        Scroll.isCategoryScroll = false
        CategoriesView.newIndex = indexPath
        collectionView.reloadData()
        delegate!.scroll(item: indexPath.row+1)
        collectionView.scrollToItem(at: CategoriesView.newIndex, at: .centeredHorizontally, animated: true)
    }

    
    
}

class CategoryCell: UICollectionViewCell {
    static let reuseID = "CategoryCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    var titleLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        view.contentMode = .scaleAspectFill
        view.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        view.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        view.textAlignment = .center
        return view
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        layer.cornerRadius = 20
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

