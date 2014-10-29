//
//  WSPlot.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 23.09.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSAxisLocationDelegate.h"
#import "WSCoordinateDelegate.h"
#import "WSDataDelegate.h"
#import "WSAxisLocation.h"

/// This is the base class for all objects that deal with plotting
/// entities to the chart. They require a delegate that provides them
/// with the coordinate system objects and (in most cases) the data
/// sets.  The data set is optional for some subclasses -- the
/// coordinate axis, for example, do not require a data set to plot
/// themselves, but they need a set of coordinates.
@class WSPlotController;

@interface WSPlot : UIView

@property (weak, nonatomic) WSPlotController *plotController;        ///< The plot controller of this plot.
@property (weak, nonatomic) id<WSAxisLocationDelegate> axisDelegate; ///< Provides the axis positioning.
@property (weak, nonatomic) id<WSCoordinateDelegate> coordDelegate;  ///< Provides the coordinate transformations.
@property (weak, nonatomic) id<WSDataDelegate> dataDelegate;         ///< Provides the data model class.

@property (readonly, nonatomic) BOOL hasData; ///< Does this type of plot support data (even if currently empty)?
@property (nonatomic) BOOL allowReordering;   ///< Allows the plot to reorder (typically this means sorting)
                                              ///< the data. Defaults to @p YES, this can significantly improve
                                              ///< performance.

/** Plot a sample data point at the given @p CGPoint (e.g. for legends
    etc.).
 */
- (void)plotSample:(CGPoint)aPoint;

/** Switch off all elements in the current plot. */
- (void)setAllDisplaysOff;

/** Force redraw of entire chart (this instance's superview). */
- (void)chartSetNeedsDisplay;

@end
