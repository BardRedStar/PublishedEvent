//
//  Event.swift
//
//  Created by Denis Kovalev
//

import Combine
import Foundation

@propertyWrapper
struct Event<Value> {
    var wrappedValue: Value? {
        didSet {
            if let value = wrappedValue {
                subject.send(value)
            }
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return subject.eraseToAnyPublisher()
    }

    private var subject = PassthroughSubject<Value, Never>()

    init() {}
}

extension Event: Publisher {
    typealias Output = Value
    typealias Failure = Never

    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Value == S.Input {
        subject.receive(subscriber: subscriber)
    }
}
