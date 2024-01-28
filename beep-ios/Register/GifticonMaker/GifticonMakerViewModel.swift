//
//  GifticonMakerViewModel.swift
//  beep-ios
//
//  Created by BeomSeok on 1/10/24.
//

import Foundation
import RxSwift
import RxCocoa

class GifticonMakerViewModel {
    
    let gifticonCandidates = BehaviorRelay<[GifticonCandidate]>(value: [])
    let selectedGifticonCandidate = BehaviorRelay<GifticonCandidate?>(value: nil)
    let gifticonFields = BehaviorRelay<[GifticonFieldStatus]>(value: [])
    let selectedGifticonFieldType = BehaviorRelay<GifticonFieldType>(value: .preview)
    
    let disposeBag = DisposeBag()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        gifticonCandidates
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] candidates in
                guard let self else { return }
                self.selectedGifticonCandidate.accept(candidates.first)
            })
            .disposed(by: disposeBag)
        
        selectedGifticonCandidate
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] selectedCandidate in
                guard let self else { return }
                let gifticonFields = selectedCandidate?.fieldsStatus() ?? []
                self.gifticonFields.accept(gifticonFields)
                self.selectedGifticonFieldType.accept(.preview)
            })
            .disposed(by: disposeBag)
    }
}
