//
//  GifticonMakerDatePicker.swift
//  beep-ios
//
//  Created by BeomSeok on 2/4/24.
//

import UIKit
import SnapKit

class GifticonMakerDatePicker: UIView {
    enum Dimension {
        static let size = CGSize(width: 318, height: 180)
    }
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        backgroundColor = Static.color.white
        layer.cornerRadius = 8
        layer.borderColor = Static.color.lightGray.cgColor
        layer.borderWidth = 1.0
        
        let yearLabel = makeLabel(text: "연")
        addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(106)
            make.height.equalTo(43)
        }
        
        let monthLabel = makeLabel(text: "월")
        addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(106)
            make.height.equalTo(43)
        }
        
        let dayLabel = makeLabel(text: "일")
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(106)
            make.height.equalTo(43)
        }
        
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = Static.color.lightGray
        addSubview(horizontalBar)
        horizontalBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(horizontalBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
    func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = Static.font.title5
        label.textColor = Static.color.fontGray
        label.textAlignment = .center
        return label
    }
    
}
