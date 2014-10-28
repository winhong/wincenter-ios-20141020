//
//  WSColor.h
//  WSColor
//
//  Created by Wolfram Schroers on 16.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

@import UIKit;

/// Convenience macro for defining RGB colors with percent-values.
#define UICOLORRGB(a, b, c) [UIColor colorWithRed:a/100.0 green:b/100.0 blue:c/100.0 alpha:1.0]

/// This category adds the implementation of factory methods for
/// colors defined by the CSS-standard. Furthermore, a convenience
/// macro is defined that allows to specify an RGB color using
/// percent-values (from 0.0 to 100.0).
///
/// The names of the factory methods for the CSS colors are @p
/// CSSColor<name> where @p <name> is of the colors (starting with a
/// capital letter) defined here:
/// http://www.w3.org/TR/CSS21/syndata.html#color-units
@interface UIColor (WSColor)

+ (UIColor *)CSSColorWhite;
+ (UIColor *)CSSColorSilver;
+ (UIColor *)CSSColorGray;
+ (UIColor *)CSSColorBlack;
+ (UIColor *)CSSColorRed;
+ (UIColor *)CSSColorMaroon;
+ (UIColor *)CSSColorYellow;
+ (UIColor *)CSSColorOlive;
+ (UIColor *)CSSColorLime;
+ (UIColor *)CSSColorGreen;
+ (UIColor *)CSSColorAqua;
+ (UIColor *)CSSColorTeal;
+ (UIColor *)CSSColorBlue;
+ (UIColor *)CSSColorNavy;
+ (UIColor *)CSSColorFuchsia;
+ (UIColor *)CSSColorPurple;
+ (UIColor *)CSSColorOrange;

@end
