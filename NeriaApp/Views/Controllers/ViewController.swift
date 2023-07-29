//
//  ViewController.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import UIKit

// MARK: - AlertProtocol
protocol AlertProtocol{
    func showAlert(title: String?, message: String?, buttonText:String?, vc:UIViewController?)
}

extension AlertProtocol {
    func showAlert(title: String?, message: String?, buttonText:String?, vc:UIViewController?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
        vc?.present(alert, animated: true, completion: nil)
    }
}

class ViewController: UIViewController, AlertProtocol {
    // MARK: - outlet
    @IBOutlet weak private var characterTableView: UITableView!
    
    // MARK: - properties
    private var mainVM: MainViewModel?
    private let firstSection: Int = 0
    private let secondSection: Int = 1
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    // MARK: - methods
    private func initialize(){
        
        configureVM()
        tableConfigure()
    }
    
    private func configureVM() {
        // MARK: - init +  binding
        mainVM = MainViewModel(coordinator: Coordinator(coordinatorNavigation: self.navigationController!))
        
        mainVM?.characterListVM.bind({[weak self] _ in
            
            self?.characterTableView.reloadData()
        })
        
        mainVM?.errorMessage.bind({ [weak self] (errorMsg) in
            
            self?.showAlert(title: self?.mainVM?.errorTitle, message: errorMsg, buttonText: self?.mainVM?.errorAlertButtonTitle, vc: self)
        })
    }
    
    private func tableConfigure() {
        
        characterTableView.rowHeight = UITableView.automaticDimension
        characterTableView.estimatedRowHeight = 50
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.register(cellType: CharacterCell.self)
        characterTableView.register(cellType: LoaderCell.self)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == firstSection{
            return mainVM?.sectionOneCount ?? 0
        } else {
            return mainVM?.sectionTwoCount ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == firstSection{
            let cell: CharacterCell = tableView.cell(cellType: CharacterCell.self)
            if let vm = mainVM {
                cell.configureCell(characterVM: vm.getCharacterVMBy(index: indexPath.row), index: indexPath.row)
            }
            return cell
        } else{
            let cell: LoaderCell = tableView.cell(cellType: LoaderCell.self)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == secondSection{
            // this code is to see the loader
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.mainVM?.sendRequest()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == firstSection{
            if let vm = mainVM {
                vm.goToDetailsVC(characterData: vm.getCharacterDataBy(index: indexPath.row))
            }
        }
    }
}

