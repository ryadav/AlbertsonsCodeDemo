//
//  AbbreviationViewController.swift
//  AlbertsonCodeDemo
//
//  Created by Apple  on 17/11/23.
//

import UIKit

class AbbreviationViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var acronymTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    lazy var viewModel: AbbreviationViewModel = {
        let viewModel = AbbreviationViewModel()
        return viewModel
    }()
    weak var viewModelProtocol: AbbreviationViewModelProtocol?

    private var debouncer: Debouncer!

    private var textFieldValue = "" {
        didSet {
            debouncer.call()
        }
    }

    // MARK: - Class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelProtocol = viewModel
        observedAcromynData()
        setUpComponents()
    }

    // MARK: - Custom methods
    func setUpComponents() {
        activityIndicator.isHidden = true
        emptyDataLabel.isHidden = true
        debouncer = Debouncer.init(delay: 1, callback: triggerDebouncerCallback)
    }

    private func triggerDebouncerCallback() {
        if !textFieldValue.isEmpty {
            acronymTextField.isEnabled = false
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            emptyDataLabel.isHidden = true
            tableView.isHidden = true
            getAbbreviationData(sf: textFieldValue)
        }
    }

    func getAbbreviationData(sf: String) {
        viewModelProtocol?.getAbbreviation(sf: sf, lf: "")
    }

    func observedAcromynData() {
        viewModelProtocol?.completion = { [weak self] (AbbreviationModel, error) in
            if let AbbreviationModel, !AbbreviationModel.isEmpty {
                DispatchQueue.main.async {
                    self?.updateUIAfterAPICall()
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self?.updateUIAfterAPICall()
                    self?.tableView.isHidden = true

                    self?.emptyDataLabel.isHidden = false
                    self?.emptyDataLabel.text = error.message
                }
            }
        }
    }

    func updateUIAfterAPICall() {
        self.acronymTextField.isEnabled = true
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }

    // MARK: - IBOutlet actions
    @IBAction func textChanged(_ sender: Any) {
        textFieldValue = (sender as? UITextField)?.text ?? ""
    }
}

// MARK: - TableView data source and delegate methods

extension AbbreviationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.AbbreviationModel.first?.lfs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AcronymsTableViewCell.self), for: indexPath) as? AcronymsTableViewCell else {
            return UITableViewCell()
        }

        if let data = viewModel.AbbreviationModel.first?.lfs?[indexPath.row] {
            cell.setUpDataOnCell(data: data)
        }

        return cell
    }
}
