//
//  IOS6NavigationViewBuilder.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

@_functionBuilder public struct IOS6NavigationViewBuilder {
    
    /// Builds an empty view from an block containing no statements, `{ }`.
    public static func buildBlock() -> TupleView<(Root,Root,Root)> {
        ViewBuilder.buildBlock(Root(EmptyView()), Root(EmptyView()), Root(EmptyView()))
    }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through
    /// unmodified.
    public static func buildBlock<C0>(_ c0: C0) -> TupleView<(Root,Root,Root)> where C0 : View {
        ViewBuilder.buildBlock(Root(EmptyView()), Root(c0), Root(EmptyView()))
    }
    
    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(Root,Root,Root)> where C0 : View, C1 : View {
        ViewBuilder.buildBlock(Root(EmptyView()), Root(c0), Root(c1))
    }
    
    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> TupleView<(Root,Root,Root)> where C0 : View, C1 : View, C2 : View {
        ViewBuilder.buildBlock(Root(c0), Root(c1), Root(c2))
    }
}

extension IOS6NavigationViewBuilder {

    /// Provides support for "if" statements in multi-statement closures, producing an `Optional` view
    /// that is visible only when the `if` condition evaluates `true`.
    public static func buildIf<Content>(_ content: Content?) -> Content? where Content : View {
        ViewBuilder.buildBlock(content)
    }

    /// Provides support for "if" statements in multi-statement closures, producing
    /// ConditionalContent for the "then" branch.
    public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> _ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
        ViewBuilder.buildEither(first: first)
    }

    /// Provides support for "if-else" statements in multi-statement closures, producing
    /// ConditionalContent for the "else" branch.
    public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> _ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
        ViewBuilder.buildEither(second: second)
    }
}

extension IOS6NavigationViewBuilder {
    public typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
}
