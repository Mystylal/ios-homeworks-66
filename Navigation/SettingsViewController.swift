//
//  SettingsViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 28.09.2026.
//

import UIKit

class SettingsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        setupTableView()
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Сортировка"
            let isOn = UserDefaults.standard.object(forKey: "isAlphabeticalSort") as? Bool ?? true
            cell.accessoryType = isOn ? .checkmark : .none
        } else {
            cell.textLabel?.text = "Поменять пароль"
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let isOn = UserDefaults.standard.object(forKey: "isAlphabeticalSort") as? Bool ?? true
            UserDefaults.standard.set(!isOn, forKey: "isAlphabeticalSort")
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            let passwordVC = PasswordViewController(mode: .create)
            passwordVC.onSuccess = { [weak self] in
                self?.dismiss(animated: true)
            }
            let navController = UINavigationController(rootViewController: passwordVC)
            present(navController, animated: true)
        }
    }
}
