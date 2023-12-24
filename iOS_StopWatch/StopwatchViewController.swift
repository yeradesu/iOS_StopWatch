//
//  StopwatchViewController.swift
//  iOS_StopWatch
//
//  Created by Yerassyl Adilkhan.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var bigCircle = UIView()
    var lilCircle = UIView()
    var countingLabel = UILabel()
    let pauseButton = UIButton()
    let resetButton = UIButton()
    let startButton = UIButton()
    
    var timer: Timer?
    var isTimerRunning = false
    var counter = 0.0
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupButtonActions()
    }
    
    // you cannot set cornerRadius in configureButtons(), therefore i had to use this function
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setCornerRadius()
    }
    
    // MARK: - PRIVAT METHODS
    private func configureUI() {
        view.backgroundColor = UIColor.init(red: 18.0/255, green: 18.0/255, blue: 18.0/255, alpha: 1)
        configureCircleViews()
        configureButtons()
    }
    
    private func configureCircleViews() {
        // big one
        let frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        bigCircle = UIView(frame: frame)
        bigCircle.layer.cornerRadius = bigCircle.frame.width / 2
        bigCircle.backgroundColor = UIColor.init(red: 38.0/255, green: 38.0/255, blue: 38.0/255, alpha: 1)
        
        view.addSubview(bigCircle)
        
        bigCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bigCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            bigCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigCircle.widthAnchor.constraint(equalToConstant: 350),
            bigCircle.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        // lil one
        let lilFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
        lilCircle = UIView(frame: lilFrame)
        lilCircle.layer.cornerRadius = lilCircle.frame.width / 2
        lilCircle.backgroundColor = UIColor.init(red: 24.0/255, green: 24.0/255, blue: 24.0/255, alpha: 1)
        
        bigCircle.addSubview(lilCircle)
        
        lilCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lilCircle.centerXAnchor.constraint(equalTo: bigCircle.centerXAnchor),
            lilCircle.centerYAnchor.constraint(equalTo: bigCircle.centerYAnchor),
            lilCircle.widthAnchor.constraint(equalToConstant: 300),
            lilCircle.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // configuring countingLabel
        countingLabel.text = "00:00,00"
        countingLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        countingLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 48, weight: .regular)
        countingLabel.textAlignment = .center
        
        lilCircle.addSubview(countingLabel)
        
        countingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countingLabel.centerXAnchor.constraint(equalTo: lilCircle.centerXAnchor),
            countingLabel.centerYAnchor.constraint(equalTo: lilCircle.centerYAnchor)
        ])
    }
    
    private func configureButtons() {
        pauseButton.backgroundColor = .darkGray
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.titleLabel?.textColor = .lightGray
        pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        pauseButton.layer.borderWidth = 2
        pauseButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        view.addSubview(pauseButton)

        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.topAnchor.constraint(equalTo: bigCircle.bottomAnchor, constant: 50),
            pauseButton.widthAnchor.constraint(equalToConstant: 80),
            pauseButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        resetButton.backgroundColor = .darkGray
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.textColor = .lightGray
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetButton.layer.borderWidth = 2
        resetButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        view.addSubview(resetButton)

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),
            resetButton.trailingAnchor.constraint(equalTo: pauseButton.leadingAnchor, constant: -35),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            resetButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        startButton.backgroundColor = UIColor.init(red: 25.0/255.0, green: 143.0/255.0, blue: 81.0/255.0, alpha: 1)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.textColor = UIColor(red: 80.0/255.0, green: 115.0/255.0, blue: 97.0/255.0, alpha: 1)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        view.addSubview(startButton)

        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 35),
            startButton.widthAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setCornerRadius() {
        pauseButton.layer.cornerRadius = pauseButton.frame.width / 2
        resetButton.layer.cornerRadius = resetButton.frame.width / 2
        startButton.layer.cornerRadius = startButton.frame.width / 2
    }
    
    private func setupButtonActions() {
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
    }
    
    private func updateTimerLabel() {
       let time = TimeInterval(counter)
       let timeString = String(format: "%02d:%02d,%02d", Int(time / 60), Int(time) % 60, Int((time.truncatingRemainder(dividingBy: 1)) * 100))
       countingLabel.text = timeString
    }
    
    // MARK: - TIMER CONTROL FUNCTIONS
    @objc func startTimer() {
       if !isTimerRunning {
           timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
           isTimerRunning = true
       }
    }

    @objc func pauseTimer() {
       if isTimerRunning {
           timer?.invalidate()
           isTimerRunning = false
       }
    }

    @objc func resetTimer() {
       timer?.invalidate()
       isTimerRunning = false
       counter = 0.0
       updateTimerLabel()
    }

    @objc func updateTimer() {
       counter += 0.01
       updateTimerLabel()
    }
}
