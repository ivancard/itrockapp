//
//  CircularSliderView.swift
//  Izipark
//
//  Created by fabian zarate on 01/02/2023.
//

import UIKit

protocol CircularProgressViewDelegate: AnyObject {
    func selectedValue(_ minutes: Int)
}

class CircularProgressView: UIView {
    
    weak var delegate: CircularProgressViewDelegate?
    
    let initialAngle = 0.625
    
    let lineWidth: CGFloat = 40
    
    let haptic = UISelectionFeedbackGenerator()
    
    var hours: Int = 0
    
    lazy var dotView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        
        let dot = UIView()
        dot.translatesAutoresizingMaskIntoConstraints = false
        dot.layer.masksToBounds = true
        dot.layer.cornerRadius = 16
        dot.backgroundColor = .white
        
        containerView.addSubview(dot)
        
        NSLayoutConstraint.activate([
            dot.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            dot.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            dot.heightAnchor.constraint(equalToConstant: 32),
            dot.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        return containerView
    }()
    
    private lazy var numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.textAlignment = .center
        numberLabel.text = "00:05"
        numberLabel.font = UIFont.Poppins.regular(withSize: bounds.height / 5)
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.textColor = .black
        return numberLabel
    }()
    
    private lazy var minutesLabel: UILabel = {
        let minRemainingLabel = UILabel()
        minRemainingLabel.text = "Horas     minutos"
        minRemainingLabel.textColor = .black
        minRemainingLabel.font = UIFont.Poppins.regular(withSize: 15)
        minRemainingLabel.textAlignment = .center
        return minRemainingLabel
    }()
    
    lazy var foregroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.primary.cgColor
        layer.position = .zero
        layer.strokeEnd = 0.1
        layer.lineWidth = lineWidth
        layer.lineCap = CAShapeLayerLineCap.round
        layer.fillColor = UIColor.clear.cgColor
        layer.add(fillAnimation, forKey: "progress")
        return layer
    }()
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.strokeColor = UIColor.whiteGreen.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeEnd = 1
        backgroundLayer.frame = bounds
        return backgroundLayer
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(minutesLabel)
        return stackView
    }()
    
    private lazy var foregroundGradientLayer: CAGradientLayer = {
        let foregroundGradientLayer = CAGradientLayer()
        foregroundGradientLayer.frame = bounds
        foregroundGradientLayer.startPoint = CGPoint(x: 0.75, y: 0.5)
        foregroundGradientLayer.endPoint =  CGPoint(x: 0.25, y: 0.5)
        foregroundGradientLayer.colors = [UIColor.primary.cgColor,
                                          UIColor.black.cgColor]
        return foregroundGradientLayer
    }()
    
    private lazy var fillAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }()
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        haptic.prepare()
        loadLayers()

        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
    }
    
    private func loadLayers() {
        let centerPoint = CGPoint(x: frame.width/2 , y: frame.height/2)
        let circularPath = UIBezierPath(arcCenter: centerPoint,
                                        radius: bounds.width / 2 - 20,
                                        startAngle: -.pi/2,
                                        endAngle: 2 * .pi - .pi/2,
                                        clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        layer.addSublayer(backgroundLayer)
        
        foregroundLayer.path = circularPath.cgPath
        foregroundGradientLayer.mask = foregroundLayer
        layer.addSublayer(foregroundGradientLayer)
        
        addSubview(infoStackView)
        addSubview(dotView)
        
        NSLayoutConstraint.activate([
            infoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            numberLabel.heightAnchor.constraint(equalToConstant: bounds.height / 5),
            
            dotView.topAnchor.constraint(equalTo: topAnchor),
            dotView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dotView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dotView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        dotView.transform = .init(rotationAngle: initialAngle)
    }
    
    @objc private func draggedView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.location(in: self)
        handleTouch(point: translation, animated: false)
    }
    
    private func handleTouch(point: CGPoint, animated: Bool) {
        let v1 = CGVector(dx: bounds.midX - bounds.midX, dy: bounds.minY - bounds.midY)
        let v2 = CGVector(dx: point.x - bounds.midX, dy: point.y - bounds.midY)
        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        var deg = angle * CGFloat(180.0 / .pi)
        if deg < 0 { deg += 360.0 }
        
        let percentage = deg/360
        let currentPercentage = foregroundLayer.strokeEnd
        
        let minute = Int(60 * percentage)
        let currentMinute = numberLabel.text?.components(separatedBy: ":").last
        
        if currentMinute != minute.description {
            if currentPercentage > 0.75 && minute < 15 {
                hours = min(23, hours + 1)
            } else if currentPercentage < 0.25 && minute > 45 {
                hours = max(0, hours - 1)
            }
            
            let time = String(format: "%02d:%02d", hours, minute)
            
            numberLabel.text = time
            haptic.selectionChanged()
            
            delegate?.selectedValue(60 * (hours + 1) + minute)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        foregroundLayer.strokeEnd = percentage
        CATransaction.commit()
        
        moveDotView(angle: angle)
    }
    
    private func moveDotView(angle: CGFloat) {
        guard angle != initialAngle else { return }
        UIView.animate(withDuration: 0, animations: { [weak self] in
            self?.dotView.transform = .init(rotationAngle: angle)
        })
    }
}
