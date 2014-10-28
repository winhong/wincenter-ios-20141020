//
//  WSColorScheme.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 02.11.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

@import UIKit;
#import "WSPlotFactoryDefaults.h"

/// This class defines and returns appropriate colors based on a given
/// color scheme constant as defined in @p WSPlotFactoryDefaults.h.
@interface WSColorScheme : NSObject <NSCoding, NSCopying>

@property (nonatomic) LPColorScheme colors; ///< Current color scheme constant.

/** Return a color scheme (factory method).
 
    @param cs The color scheme constant.
    @return An instance of a color scheme. */
+ (instancetype)colorScheme:(LPColorScheme)cs;

/** Initialize a color scheme.
 
    @param cs The color scheme constant.
    @return An initialized color scheme. */
- (instancetype)initWithScheme:(LPColorScheme)cs;

/** Initialize a color scheme with default white color. */
- (instancetype)init;

/** Return the foreground color for the current color scheme. */
- (UIColor *)foreground;

/** Return the background color for the current color scheme. */
- (UIColor *)background;

/** Return the receded color for the current color scheme. */
- (UIColor *)receded;

/** Return the highlight color for the current color scheme. */
- (UIColor *)highlight;

/** Return the spotlight color for the current color scheme. */
- (UIColor *)spotlight;

/** Return the shadow color for the current color scheme. */
- (UIColor *)shadow;

/** Return an array of alternative highlight colors. */
- (NSArray *)highlightArray;

/** Return the primary alert color. */
- (UIColor *)alert;

/** Return the secondary alert color. */
- (UIColor *)alertSecondary;

@end
