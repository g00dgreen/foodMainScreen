//
//  ViewController.swift
//  test1
//
//  Created by Артем Макар on 3.04.23.
//

import UIKit
import SnapKit

protocol ScrollTableProtocol {
    func scroll(item: Int)
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ScrollTableProtocol {
    
    var presenter: MainViewPresenterProtocol!
    var delegate: ScrollTableHeaderProtocol?
    
    let table = UITableView()
    var cellsHight: [Int: CGFloat] = [:]
    let tableHeader = CategoriesView(categories: ProductList.products)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        table.dataSource = self
        table.delegate = self
        
        let width1 = UIScreen.main.bounds.size.width
        lazy var bannerHeaderView: BannersView = {
            let width = width1
            let height = 112.0
            let bannerView = BannersView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            return bannerView
        }()
        
        table.frame = CGRect(x: 0, y: 104, width: view.frame.width, height: view.frame.height - (104+50))
        table.tableHeaderView = bannerHeaderView
        bannerHeaderView.update(bannersString: ["1", "1", "1", "1", "1"])
        let nib = UINib(nibName: "AdCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "AdCell")
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        view.addSubview(table)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return testData.count
        return presenter.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == (presenter.data?.count ?? 1)-1 {
            return (cellsHight[indexPath.row] ?? 100) + 10
        }
       return cellsHight[indexPath.row] ?? 200

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell")! as! AdCell
        cell.config(image: (presenter.data?[indexPath.row].image), header: presenter.data?[indexPath.row].title ?? "test", description: presenter.data?[indexPath.row].description)
        print("first", indexPath.row)
        cellsHight[indexPath.row] = CGFloat(((cell.descriptionLabel.lines!.count * 16) + 90) + 18 * cell.headerLabel.lines!.count)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableHeader.delegate = self
        return tableHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        56
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Scroll.isCategoryScroll == true {
            let offset = scrollView.contentOffset.y
            var c = 0.0
            for i in 0..<(presenter.data?.count ?? 0) {
                if c + cellsHight[i]! > offset {
                    tableHeader.scrollHeader(item: i/3+1)
                    break
                }
                c += cellsHight[i]!
            }
        }
    }
    func scroll(item: Int) {
        print(Scroll.isCategoryScroll)
        Scroll.isCategoryScroll = false
        let pos = ((item-1) * APISettings.numberOfCategories) + 1
        let indexPath = IndexPath(item: pos-1, section: 0)
        table.scrollToRow(at: indexPath, at: .top, animated: true)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.3) {
            Scroll.isCategoryScroll = true
        }
    }
    
}

extension MainViewController: MainViewProtocol {
    func succes() {
        print("testik2")
        table.reloadData()
    }
}





extension MainViewController {
    func initialize() {
        navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
        self.navigationController!.navigationBar.clipsToBounds = true
        self.tabBarController?.tabBar.isTranslucent = false

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBarController?.tabBar.standardAppearance = appearance
            tabBarController?.tabBar.scrollEdgeAppearance = tabBarController?.tabBar.standardAppearance

        }

    }
    
    func makeLeftBarButtonItems() -> [UIBarButtonItem] {
        let cityLabel = UIBarButtonItem(title: "Москва", style: .plain, target: .none, action: .none)
        cityLabel.tintColor = .black
        let dropDownButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.down"), target: self, action: #selector(dropDownButtonAction))
        dropDownButton.tintColor = UIColor(hex: "#1c222bff")
        return [cityLabel, dropDownButton]
    }
    
    @objc func dropDownButtonAction() {
        print("dropDownButtonAction")
    }
}



