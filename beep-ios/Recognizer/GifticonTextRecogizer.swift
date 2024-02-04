//
//  GifticonTextRecogizer.swift
//  beep-ios
//
//  Created by BeomSeok on 1/28/24.
//

import MLKit
import MLKitTextRecognition
import MLKitTextRecognitionKorean
import RxSwift

class GifticonTextRecogizer {
    let option = KoreanTextRecognizerOptions()
    let recoginizer: TextRecognizer
    
    init() {
        self.recoginizer = TextRecognizer.textRecognizer(options: option)
    }
    
    func parse(image: UIImage) -> Single<Text> {
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        return Single<Text>.create { [weak self] single in
            guard let self else {
                single(.failure(GifticonRecognizerError.invalidTextRecognizer))
                return Disposables.create()
            }
            
            self.recoginizer.process(visionImage) { result, error in
                guard let result, error == nil else {
                    single(.failure(error ?? GifticonRecognizerError.invalidTextRecognitionResult))
                    return
                }
                single(.success(result))   
            }
            
            return Disposables.create()
            
        }
    }
}
