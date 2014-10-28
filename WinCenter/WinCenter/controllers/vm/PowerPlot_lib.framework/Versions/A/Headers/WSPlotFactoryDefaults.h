//
//  WSPlotFactoryDefaults.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 20.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

/// This file defines common names for configuration options of @p
/// WSChart factory methods. The options are shared by several
/// factories, although not every factory will support all options
/// provided here. Options applying to specific charts only (e.g., the
/// line style of a line plot or the bar style options of a bar plot
/// etc.) should be put into the individual categories, not in this
/// file.

/** Styles the coordinate axis system can be drawn. */
typedef NS_ENUM(NSInteger, CSStyle) {
    kCSNone = -1, ///< Do not draw coordinate system axis.
    kCSPlain,     ///< Axis with plain lines.
    kCSArrows,    ///< Axis with arrows.
    kCSBoxed,     ///< Axis with lines, chart drawn in a box.
    kCSGrid       ///< Axis with arrows, grid bars at major ticks.
};

/** Color schemes for a premade chart. */
typedef NS_ENUM(NSInteger, LPColorScheme) {
    kColorUndefined = -1, ///< Undefined color scheme.
    kColorWhite,          ///< Black and orange on white.
    kColorLight,          ///< Black and orange on light gray.
    kColorGray,           ///< Darker gray.
    kColorDark,           ///< Dark background, light foreground.
    kColorDarkGreen,      ///< Dark background, green foreground.
    kColorDarkBlue,       ///< Dark background, blue foreground.
    kColorCustom          ///< A custom color scheme has been provided.
};

