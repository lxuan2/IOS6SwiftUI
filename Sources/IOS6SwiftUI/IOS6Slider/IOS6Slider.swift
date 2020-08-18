//
//  IOS6Slider.swift
//  IOS6
//
//  Created by Xuan Li on 7/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Slider<ValueLabel: View>: View {
    @Environment(\._ios6SliderStyle) private var style
    let configuration: IOS6SliderStyleConfiguration
    
    public var body: some View {
        style.makeBody(configuration: configuration)
    }
}

extension IOS6Slider {
    
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///     - minimumValueLabel: A `View` that describes `bounds.lowerBound`.
    ///     - maximumValueLabel: A `View` that describes `bounds.lowerBound`.
    ///     - label: A `View` that describes the purpose of the instance.
    ///
    /// The `value` of the created instance will be equal to the position of
    /// the given value within `bounds`, mapped into `0...1`.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `IOS6Slider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, onEditingChanged: @escaping (Bool) -> Void = { _ in }, minimumValueLabel: ValueLabel, maximumValueLabel: ValueLabel) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        let binding: Binding<CGFloat> =
            Binding(get: {
                if bounds.contains(value.wrappedValue) {
                    return CGFloat(value.wrappedValue / (bounds.upperBound - bounds.lowerBound))
                } else {
                    let newV = min(max(value.wrappedValue, bounds.lowerBound), bounds.upperBound)
                    DispatchQueue.main.async {
                        value.wrappedValue = newV
                    }
                    return CGFloat(newV)
                }
            }, set: { newValue in
                let newWrappedValue = V(newValue) * (bounds.upperBound - bounds.lowerBound)
                if value.wrappedValue != newWrappedValue {
                    value.wrappedValue = newWrappedValue
                }
            })
        self.configuration = IOS6SliderStyleConfiguration(value: binding, minimumValueLabel: minimumValueLabel, maximumValueLabel: maximumValueLabel, onEditingChanged: onEditingChanged)
    }
    
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - step: The distance between each valid value.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///     - minimumValueLabel: A `View` that describes `bounds.lowerBound`.
    ///     - maximumValueLabel: A `View` that describes `bounds.lowerBound`.
    ///     - label: A `View` that describes the purpose of the instance.
    ///
    /// The `value` of the created instance will be equal to the position of
    /// the given value within `bounds`, mapped into `0...1`.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `IOS6Slider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }, minimumValueLabel: ValueLabel, maximumValueLabel: ValueLabel) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        let binding: Binding<CGFloat> =
            Binding(get: {
                let (newV, newG) = clipToStep(value.wrappedValue, in: bounds, step: step)
                if newV != value.wrappedValue {
                    DispatchQueue.main.async {
                        value.wrappedValue = newV
                    }
                }
                return newG
            }, set: { newValue in
                let newV = regularizeToStep(newValue, in: bounds, step: step)
                let newWrappedValue = V(newV)
                if value.wrappedValue != newWrappedValue {
                    value.wrappedValue = newWrappedValue
                }
            })
        self.configuration = IOS6SliderStyleConfiguration(value: binding, minimumValueLabel: minimumValueLabel, maximumValueLabel: maximumValueLabel, onEditingChanged: onEditingChanged)
    }
}

extension IOS6Slider where ValueLabel == EmptyView {
    
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///     - label: A `View` that describes the purpose of the instance.
    ///
    /// The `value` of the created instance will be equal to the position of
    /// the given value within `bounds`, mapped into `0...1`.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `IOS6Slider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        let binding: Binding<CGFloat> =
            Binding(get: {
                if bounds.contains(value.wrappedValue) {
                    return CGFloat(value.wrappedValue / (bounds.upperBound - bounds.lowerBound))
                } else {
                    let newV = min(max(value.wrappedValue, bounds.lowerBound), bounds.upperBound)
                    DispatchQueue.main.async {
                        value.wrappedValue = newV
                    }
                    return CGFloat(newV)
                }
            }, set: { newValue in
                let newWrappedValue = V(newValue) * (bounds.upperBound - bounds.lowerBound)
                if value.wrappedValue != newWrappedValue {
                    value.wrappedValue = newWrappedValue
                }
            })
        self.configuration = IOS6SliderStyleConfiguration(value: binding, minimumValueLabel: EmptyView(), maximumValueLabel: EmptyView(), onEditingChanged: onEditingChanged)
    }
    
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - step: The distance between each valid value.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///     - label: A `View` that describes the purpose of the instance.
    ///
    /// The `value` of the created instance will be equal to the position of
    /// the given value within `bounds`, mapped into `0...1`.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `IOS6Slider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        let binding: Binding<CGFloat> =
            Binding(get: {
                let (newV, newG) = clipToStep(value.wrappedValue, in: bounds, step: step)
                if newV != value.wrappedValue {
                    DispatchQueue.main.async {
                        value.wrappedValue = newV
                    }
                }
                return newG
            }, set: { newValue in
                let newV = regularizeToStep(newValue, in: bounds, step: step)
                let newWrappedValue = V(newV)
                if value.wrappedValue != newWrappedValue {
                    value.wrappedValue = newWrappedValue
                }
            })
        self.configuration = IOS6SliderStyleConfiguration(value: binding, minimumValueLabel: EmptyView(), maximumValueLabel: EmptyView(), onEditingChanged: onEditingChanged)
    }
}

struct IOS6Slider_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Slider(value: .constant(0.2))
    }
}

fileprivate func clipToStep<V>(_ value: V, in bounds: ClosedRange<V>, step: V.Stride) -> (V, CGFloat) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    if bounds.contains(value) {
        let x = (CGFloat(value) / CGFloat(step)).rounded() * CGFloat(step)
        return (V(x), x/CGFloat(bounds.upperBound - bounds.lowerBound))
    } else {
        let newV = min(max(value, bounds.lowerBound), bounds.upperBound)
        var x = CGFloat(newV) / CGFloat(step).rounded() * CGFloat(step)
        if V(x) > bounds.upperBound {
            x -= CGFloat(step)
        } else if V(x) < bounds.lowerBound {
            x += CGFloat(step)
        }
        return (V(x), x/CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

fileprivate func regularizeToStep<V>(_ value: CGFloat, in bounds: ClosedRange<V>, step: V.Stride) -> V where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let newValue = value * CGFloat(bounds.upperBound - bounds.lowerBound)
    let clipped = (value / CGFloat(step)).rounded() * CGFloat(step)
    if bounds.contains(V(clipped)) {
        return V(clipped)
    } else {
        let newV = min(max(newValue, CGFloat(bounds.lowerBound)), CGFloat(bounds.upperBound))
        var x = CGFloat(newV) / CGFloat(step).rounded() * CGFloat(step)
        if V(x) > bounds.upperBound {
            x -= CGFloat(step)
        } else if V(x) < bounds.lowerBound {
            x += CGFloat(step)
        }
        return V(x)
    }
}
