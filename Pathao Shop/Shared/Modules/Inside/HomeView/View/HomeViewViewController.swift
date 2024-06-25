//
//  HomeViewViewController.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: HomeViewViewController
final class HomeViewViewController: BaseHomeViewViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var badgeButton : BadgeButton!
    private var router: HomeViewRouter?
    private let viewModel: HomeViewViewModelType
    var displayModel = HomeViewDisplayModel()
    
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    let shopApiSubject = PassthroughSubject< Parameters, Never>()
    
    
    
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: HomeViewViewModelType,
         router: HomeViewRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        setupRouter()
        viewDidLoadSubject.send()
        let params: Parameters = ["results": "20"]
        shopApiSubject.send(params)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
}

// MARK: Private Default Methods
private extension HomeViewViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }
    
    /// Setup UI
    private func setupUI() {
        tableView.registerCell(HomeViewTableCell.self)
        self.updateStore()
        self.badgeButton.handleTapToAction {
            self.router?.routeToStore()
        }
    }
    
    /// Bind viewmodel
    private func bind(to viewModel: HomeViewViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = HomeViewViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), shopApiSubject: shopApiSubject.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }
    
    /// Render UI
    private func render(_ state: HomeViewViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        case .apiFailure(customError: let customError):
            showToast(message: customError.body)
        case .apiSuccess(response: let response):
            self.displayModel.shopResponse = response
            self.tableView.reloadData()
            
        }
    }
    
}

extension HomeViewViewController : HomeViewTableCellDelegate{
    func updateStore() {
        self.badgeButton.setBadgeValue(StoreManager.shared.itemCount)
        
    }
    
    func seemoreButtonTappe(position: Int?) {
        if let validData = self.displayModel.dataSource[position ?? 0] as? ShopTableCellViewModel {
            self.router?.routeToCategoryItem(data: validData.data)
        }
        
    }
    
    
}

extension HomeViewViewController : StoreViewControllerDelegate,CategoryItemViewControllerDelegate{
    func reloadHome() {
        self.updateStore()
        self.tableView.reloadData()
    }
}

// MARK: Private Actions
extension HomeViewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let validShopDisplayModel = self.displayModel.dataSource[indexPath.row] as? ShopTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableCell.nameId) as! HomeViewTableCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validShopDisplayModel.data)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
