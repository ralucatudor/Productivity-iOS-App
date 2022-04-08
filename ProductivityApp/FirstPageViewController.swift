//
//  FirstPageViewController.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 08.04.2022.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    private let pomodoroButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pomodoro Technique", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do additional setup after loading the view.
        title = "Productivity App"
        
        view.addSubview(pomodoroButton)
        pomodoroButton.addTarget(self, action: #selector(didTapPomodoroButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pomodoroButton.frame = CGRect(
            x: 80,
            y: view.frame.size.height-300-view.safeAreaInsets.bottom,
            width: view.frame.size.width-160,
            height: 50
        )
    }
    
    @objc private func didTapPomodoroButton() {
        // Add `guard` because `URL` initializer returns an Optional.
        guard let url = URL(string: "https://pomofocus.io/") else {
            return
        }
        let webViewController = WebViewViewController(url: url, title: "Pomodoro Technique")
        let navigationViewController = UINavigationController(rootViewController: webViewController)
        present(navigationViewController, animated: true)
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
