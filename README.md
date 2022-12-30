# Published Event

A simple property wrapper over `PassthroughSubject` to create publishable properties that don't emit value right after subscription.

## 💿 Installation 

Add `PublishedEvent` directory from this repository into your project and that's it!

## 🪄 How to use 

The following example show how to declare **Event** variable and subscribe on it.

❗️ Pay attention that even though value has optional type on declaration, it is not optional in subscription!

```swift title="Common data example"
/// Declaration
/// Make it `private(set)` to restrict changing value outside of the class
@Event private(set) var updateStringEvent: String?

/// Subscription
/// This subscription won't emit right after subscription as `PassthroughSubject` does.
subscription = $updateStringEvent.sink { value in
    // Value is not optional!
    print("New value is \(value)")
}

/// Emit value
updateStringEvent = "I love publishers 😍"
```

It was the example with usual data. But how to declare Event with optional data type? Things are simple - just add the second optional 🙃

```swift title="Optional data example"
/// Declaration
/// Make it double-optional to get optional value in subscription
@Event private(set) var updateStringEvent: String?? 

/// Subscription
subscription = $updateStringEvent.sink { value in
    if let value = value {
        print("New value is \(value)")
    } else {
        print("New value is null")
    }
}

/// Emit value
updateStringEvent = nil // or some string value
```

And the last example, how to use it if we want to just emit some event, without value.
The answer is - just make the Void type!

```swift title="Void example"
/// Declaration
@Event private(set) var dataLoadedEvent: Void? 

/// Subscription
subscription = $dataLoadedEvent.sink {
    print("Data was loaded")
}

/// Emit value
updateStringEvent = ()
```