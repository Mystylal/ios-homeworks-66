//
//  InfoViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit
                
class InfoViewController: UIViewController {
    
     private lazy var textLabel: UILabel = {
         let label = UILabel()
         label.textColor = .white
         label.numberOfLines = 0
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let button = UIButton(type: .system)
        button.setTitle("UI Alert", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for:.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.addSubview(textLabel)
        view.addSubview(orbitalPeriodLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: orbitalPeriodLabel.topAnchor, constant: -20),
            
            orbitalPeriodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orbitalPeriodLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            orbitalPeriodLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
        fetchPosts()
        fetchPlanet()
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
    
    private func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/41") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return 
            }
            if let httpResponse = response as? HTTPURLResponse{
                print(httpResponse.allHeaderFields)
                print(httpResponse.statusCode)
            }
            guard let data else { return }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let title = json["title"] as? String {
                    let post = PostModel(title: title)
                    DispatchQueue.main.async {
                        self.textLabel.text = post.title
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func fetchPlanet(){
        guard let url = URL(string: "https://swapi.info/api/planets/1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let data else { return }
            
            do {
                let planet = try JSONDecoder().decode(Planet.self, from: data)
                DispatchQueue.main.async {
                    self.orbitalPeriodLabel.text = "Период обращения Татуина: \(planet.orbitalPeriod)"
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
