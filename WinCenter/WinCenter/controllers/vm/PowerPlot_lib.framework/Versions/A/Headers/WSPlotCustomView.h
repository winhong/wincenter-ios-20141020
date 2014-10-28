//
//  WSPlotCustomView.h
//  PowerPlot_lib
//
//  Created by Dr. Wolfram Schroers on 4/6/14.
//  Copyright (c) 2010-2014 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSPlot.h"

@class WSPlotCustomView;

/** Styles the custom view can be positioned relative to the data
    point. */
typedef NS_ENUM(NSInteger, WSCustomPositioning) {
    kCustomPositioningNone = -1,    ///< Don't use any positioning rules.
    kCustomPositioningCenter,       ///< Center the view to the data point.
    kCustomPositioningLeftXTopY     ///< Set the object's top-left corner to the data point.
};

@protocol WSPlotCustomViewDataSource

/// @return The view (a subclass of @p UIView) corresponding to the
/// ith data point.
- (UIView *)plotCustomView:(WSPlotCustomView *)customView
       viewForDatumAtIndex:(NSUInteger)index;

@end

/// This class puts custom views at the locations indicated by the
/// data set associated with this plot. The custom views are supplied
/// using a data source pattern. If the data source is not set, this
/// class does nothing.
@interface WSPlotCustomView : WSPlot

/// The data source for the custom views.
@property (nonatomic, weak) id<WSPlotCustomViewDataSource> dataSource;

/// The positioning rule before applying the offset. Defaults to @p
/// kCustomPositioningCenter.
@property (nonatomic) WSCustomPositioning customPositioning;

/// The offset in X-direction to apply when placing the custom
/// view. Defaults to 0.
@property (nonatomic) NAFloat offsetX;

/// The offset in X-direction to apply when placing the custom
/// view. Defaults to 0.
@property (nonatomic) NAFloat offsetY;

@end

