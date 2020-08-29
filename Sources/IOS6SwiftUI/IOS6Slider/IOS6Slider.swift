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
//            .onAppear {
//            // Init handler correct value
//        }
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
                CGFloat((min(max(value.wrappedValue, bounds.lowerBound), bounds.upperBound) - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound))
            }, set: {
                value.wrappedValue = min(max(V($0), 0), 1) * (bounds.upperBound - bounds.lowerBound) + bounds.lowerBound
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
                CGFloat((min(max(value.wrappedValue, bounds.lowerBound), bounds.upperBound) - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound))
            }, set: { newValue in
                let newV = regularizeToStep(newValue, in: bounds, step: step)
                if value.wrappedValue != newV {
                    value.wrappedValue = newV
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
                CGFloat((min(max(value.wrappedValue, bounds.lowerBound), bounds.upperBound) - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound))
            }, set: {
                value.wrappedValue = min(max(V($0), 0), 1) * (bounds.upperBound - bounds.lowerBound) + bounds.lowerBound
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
                CGFloat((min(max(value.wrappedValue, bounds.lowerBound), bounds.upperBound) - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound))
            }, set: { newValue in
                let newV = regularizeToStep(newValue, in: bounds, step: step)
                if value.wrappedValue != newV {
                    value.wrappedValue = newV
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

fileprivate func regularizeToStep<V>(_ value: CGFloat, in bounds: ClosedRange<V>, step: V.Stride) -> V where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let projected = (value * CGFloat(bounds.upperBound - bounds.lowerBound) / CGFloat(step)).rounded() * CGFloat(step) + CGFloat(bounds.lowerBound)
    let clipped = min(bounds.upperBound, max(bounds.lowerBound, V(projected)))
    
    return clipped
}
