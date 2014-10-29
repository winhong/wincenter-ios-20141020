//
//  WSPlotBar.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 07.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSPlot.h"
#import "WSDatumCustomization.h"

/// This class plots a data set consisting of X- and Y-values as a bar
/// plot. The appearance of the bars is either unified, i.e., every
/// bar looks the same, or customized, i.e., every bar has
/// individually different properties which are stored in the custom
/// slot of each @p WSDatum in the @p dataD property. In either case
/// the appearance of bars is described by instances of the @p
/// WSBarProperties class.
@class WSBarProperties;

@interface WSPlotBar : WSPlot <WSDatumCustomization>

/** Bar customization. */
@property (strong, nonatomic) WSBarProperties *propDefault;

/** Are distances of X-values equal?

    Return a @p BOOL indicating if the distances of X-values for all
    data points are identical. The check is done in data coordinates,
    thus for nonlinear coordinate scales this is not a meaningful
    method to use.

    @return Result of checking distances.
 */
- (BOOL)isDistanceConsistent;

/** @brief Set the width of the default bar such that bars touch.
 
    Do nothing if the data is not consistent as determined by @p
    isDataConsistent method.
 */
- (void)widthTouchingBars;

@end
