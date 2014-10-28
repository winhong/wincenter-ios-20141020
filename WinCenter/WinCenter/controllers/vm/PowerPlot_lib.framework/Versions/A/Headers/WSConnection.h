//
//  WSConnection.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 18.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreGraphics;
#import "NARange.h"

/** Default connection strength. */
#define kStrengthDefault 1.0

/** Direction of a connection. */
typedef NS_ENUM(NSInteger, WSGDirection) {
    kGConnectionNone = -1, ///< No connection.
    kGDirectionNone,       ///< No direction.
    kGDirection,           ///< Direction from -> to.
    kGDirectionInverse,    ///< Direction to -> from.
    kGDirectionBoth        ///< Bidirectional.
};

/// This class describes the properties of a single connection in
/// instances of @p WSGraphConnections.
@interface WSConnection : NSObject <NSCopying, NSCoding>

@property NSUInteger from;                   ///< Starting location index in a WSData object.
@property NSUInteger to;                     ///< Ending location index in a WSData object.
@property WSGDirection direction;            ///< Direction of connection.
@property NAFloat strength;                  ///< Strength of a connection (abstract concept).
@property (copy, nonatomic) NSString *label; ///< Connection label.
@property (copy, nonatomic) UIColor *color;  ///< Connection color.

/** Return a connection from 0 to 0 (factory method). */
+ (instancetype)connection;

/** Return a connection from a to b (factory method). */
+ (instancetype)connectionFrom:(NSUInteger)a
                            to:(NSUInteger)b;

/** Return a connection from a to b with a given strength (factory
    method).
 */
+ (instancetype)connectionFrom:(NSUInteger)a
                            to:(NSUInteger)b
                      strength:(NAFloat)s;

/** Sets a connection from node 0 to 0 with default configuration. */
- (instancetype)init;

/** Initialize a connection from a to b. */
- (instancetype)initFrom:(NSUInteger)a
                      to:(NSUInteger)b;

/** Initializer with connection from a to b with a given strength. */
- (instancetype)initFrom:(NSUInteger)a
                      to:(NSUInteger)b
                strength:(NAFloat)s;

@end
