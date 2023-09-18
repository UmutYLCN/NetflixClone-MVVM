//
//  Observable.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 17.09.2023.
//

import Foundation

class Observable<T> {
    
    var value : T? {
        
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener : ((T?) -> Void)?
    
    func bind(_ listener : @escaping ( (T?)-> Void)) {
        listener(value)
        self.listener = listener
    }
}
