//
//  InfoViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit
                
class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let button = UIButton(type: .system)
        button.setTitle("UI Alert", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for:.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
          button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Фокус",
            message: "Выберите",
            preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Шар", style: .default) { _ in
            print("Бабах")
        }

        let action2 = UIAlertAction(title: "Шляпа", style: .cancel) { _ in
            print("Кролик")
        }

        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}
