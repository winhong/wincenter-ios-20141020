//
//  WSDataDelegate.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 07.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "NARange.h"

@class WSData;
@class WSGraphConnections;

/// This protocol defines methods that must be implemented by a class
/// that provides access to a data model in PowerPlot. The methods
/// cover the minimum access methods that any model is required to
/// implement. Typically, the @p WSPlotController that holds a strong
/// reference to the data set provides access through the methods
/// defined in this protocol. This is then used by the view held by
/// the plot controller to access the data.
///
/// If the data source is not of type @p WSData, but of type @p
/// WSGraph then the optional method to return the set of @p
/// WSGraphConnections should be implemented, too.
@protocol WSDataDelegate <NSObject>

@required

@property (nonatomic, strong) WSData *dataD; ///< Data model handled by the controller.

/** Return the X-axis range covered by the current data set. */
- (NARange)dataRangeXD;

/** Return the Y-axis range covered by the current data set. */
- (NARange)dataRangeYD;

@optional

/** Return the associated connections from the data source. */
- (WSGraphConnections *)connections;

/** Inform the controller that the data has been updated. */
- (void)dataDidUpdate;

@end
