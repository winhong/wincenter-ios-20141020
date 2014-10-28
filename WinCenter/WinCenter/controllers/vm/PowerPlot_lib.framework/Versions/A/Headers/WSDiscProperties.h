//
//  WSDiscProperties.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 1/22/12.
//  Copyright (c) 2012-2013 Numerik & Analyse Schroers. All rights reserved.
//

@import UIKit;
#import "WSCustomProperties.h"
#import "NAAmethyst.h"

/** Styles the discs can be drawn. */
typedef NS_ENUM(NSInteger, WSDiscStyle) {
    kDiscPlotNone = -1, ///< Do not draw any discs.
    kDiscPlotContour,   ///< Show the outline only.
    kDiscPlotFilled,    ///< Show only the filled disc.
    kDiscPlotAll        ///< Show the filling plus outline.
};

/// This class describes the customizable properties of a disc in a @p
/// WSPlotDisc plot. Instances can be stored inside the @p customDatum
/// property a @p WSDatum object for use of individual discs or as a
/// generic object describing all discs in a @p WSPlotDisc.
@interface WSDiscProperties : WSCustomProperties

@property (nonatomic) NAFloat lineWidth;        ///< Width of outline.
@property (copy, nonatomic) UIColor *lineColor; ///< Color of outline.
@property (copy, nonatomic) UIColor *fillColor; ///< Filling color.
@property (nonatomic) WSDiscStyle discStyle;    ///< Style for drawing the discs.

@end
