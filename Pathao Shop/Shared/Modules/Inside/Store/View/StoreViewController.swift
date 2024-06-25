//
//  StoreViewController.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine


protocol StoreViewControllerDelegate : AnyObject {
    func reloadHome()
}
// MARK: StoreViewController
final class StoreViewController: BaseStoreViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonView : OTDynamicButton!
    @IBOutlet weak var totalAmmountView: UIView!
    @IBOutlet weak var totalAmmount : UILabel!
    private var router: StoreRouter?
    private let viewModel: StoreViewModelType
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
    var displayModel = StoreDisplayModel()
    var delegate : StoreViewControllerDelegate?
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: StoreViewModelType,
         router: StoreRouter) {
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
        self.displayModel.storItemData = StoreManager.shared.getStoreItems()
        updateTotal()
    }
    
}



// MARK: Private Default Methods
private extension StoreViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }
    
    /// Setup UI
    private func setupUI() {
        tableView.registerCell(StoreTableCell.self)
        tableView.registerCell(EmptyStoreTableViewCell.self)
        loadDefaultView()
    }
    
    func loadDefaultView(){
        let backButtonViewModel = OTDynamicButtonViewModel(img: theme.imageTheme.navBack.withRenderingMode(.alwaysOriginal), title: "", titleFont: nil, titleColor: theme.colorTheme.clearColor, backgroundColor: theme.colorTheme.clearColor, borderColor: theme.colorTheme.clearColor, cornerRadius: 0, isHidden: false)
        self.backButtonView.configureView(viewModel: backButtonViewModel) { [weak self] sender in
            if self?.displayModel.isDataChange ?? false {
                self?.delegate?.reloadHome()
            }
            self?.router?.back()
        }
    }
    
    func updateTotal(){
        let totalAmmount = StoreManager.shared.totalAmmount()
        if totalAmmount > 0{
            let formatedTaotalAmmount = AppUtilities.shared.getFormattedPrice(price: totalAmmount)
            self.totalAmmount.text = formatedTaotalAmmount
        }else {
            self.totalAmmountView.isHidden = true
        }
    }
    
    /// Bind viewmodel
    private func bind(to viewModel: StoreViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = StoreViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }
    
    /// Render UI
    private func render(_ state: StoreViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        }
    }
    
}

extension StoreViewController : StoreTableCellDelegate{
    func addButtonTapped(position: IndexPath?) {
        if let cell = tableView.cellForRow(at: position!) as? StoreTableCell {
            if let selectedItem = self.displayModel.dataSource[position?.row ?? 0] as? StoreTableViewCellViewModel {
                self.displayModel.isDataChange = true
                StoreManager.shared.saveItem(item: selectedItem.data)
                let itemCount = StoreManager.shared.getSelectedItemCount(item: selectedItem.data)
                let total = itemCount * (selectedItem.data?.price ?? 0)
                cell.updateCell(count: itemCount, total: total)
                updateTotal()
            }
        }
    }
    
    func removeButtonTapped(position: IndexPath?) {
        if let cell = tableView.cellForRow(at: position!) as? StoreTableCell {
            if let selectedItem = self.displayModel.dataSource[position?.row ?? 0] as? StoreTableViewCellViewModel {
                self.displayModel.isDataChange = true
                StoreManager.shared.removeItem(item: selectedItem.data)
                let itemCount = StoreManager.shared.getSelectedItemCount(item: selectedItem.data)
                if itemCount < 1{
                    self.displayModel.storItemData = StoreManager.shared.getStoreItems()
                    self.tableView.reloadData()
                }else{
                    let total = itemCount * (selectedItem.data?.price ?? 0)
                    cell.updateCell(count: itemCount, total: total)
                }
                updateTotal()
            }
        }
    }
    
    
}

extension StoreViewController : EmptyStoreTableDelegate{
    func addItem() {
        if self.displayModel.isDataChange ?? false {
            self.delegate?.reloadHome()
        }
        self.router?.back()
    }
    
    
}

// MARK: Private Actions
extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        if let validStoreItemModel = self.displayModel.dataSource[indexPath.row] as? StoreTableViewCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableCell.nameId) as! StoreTableCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validStoreItemModel.data)
            return cell
        } else if let validEmptyTableModel = self.displayModel.dataSource[indexPath.row] as? EmptyStoreTableViewCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyStoreTableViewCell.nameId) as! EmptyStoreTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell()
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
