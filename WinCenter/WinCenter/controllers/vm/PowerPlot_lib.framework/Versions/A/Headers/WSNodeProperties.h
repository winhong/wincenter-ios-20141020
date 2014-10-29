//
//  WSNodeProperties.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 19.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "NARange.h"
#import "WSCustomProperties.h"

/** Configuration of default node appearance (in bounds coordinates). */
#define kNodeWidth 80.0
#define kNodeHeight 30.0
#define kOutlineStroke 2.0
#define kShadowScale 5.0
#define kLabelPadding 2.0
#define kCArrowLength 10.0

/// This class describes the customizable properties of a node in a
/// WSPlotGraph plot. Instances can be stored inside the customDatum
/// property of a WSDatum object for use of individual node styles or
/// used as a generic description for all nodes in a WSPlotGraph.
///
/// The @p CGRect of a node is determined by the origin based on the
/// @p valueX and @p valueY properties after an appropriate coordinate
/// transformation and the size as given by the size property of this
/// class.
///
/// @note In a given graph, a node may not have an individual style
///       by default.
@interface WSNodeProperties : WSCustomProperties

@property (nonatomic) CGSize size;                 ///< Size of the node in bounds coordinates.
@property (nonatomic) NAFloat outlineStroke;       ///< Width of outline stroke.
@property (nonatomic) NAFloat shadowScale;         ///< Offset and blur of shadow.
@property (nonatomic) NAFloat labelPadding;        ///< Padding of node label (all directions).
@property (nonatomic, getter = isShadowEnabled) BOOL shadowEnabled; ///< Does the node have a shadow?
@property (copy, nonatomic) UIColor *outlineColor; ///< Color of node outline.
@property (copy, nonatomic) UIColor *nodeColor;    ///< Color of node filling.
@property (copy, nonatomic) UIColor *shadowColor;  ///< Color of node shadow.
@property (copy, nonatomic) UIColor *labelColor;   ///< Color of the node label text.
@property (copy, nonatomic) UIFont *labelFont;     ///< Font of the node label text.

@end
