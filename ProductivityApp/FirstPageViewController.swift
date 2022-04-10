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
    
    let viewToAnimate = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

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
        
        viewToAnimate.backgroundColor = .link
        viewToAnimate.center = view.center
        view.addSubview(viewToAnimate)
        animate()
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
    
    @objc func animate() {
        UIView.animate(withDuration: 2,
                       animations: {
                        self.viewToAnimate.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                        self.viewToAnimate.center = self.view.center
                       }, completion: { _ in
                        self.viewToAnimate.removeFromSuperview()
                    })
    }
}
