//
//  WSCoordinate.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 23.09.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "NARange.h"
#import "WSCoordinateDirection.h"
#import "WSCoordinateTransform.h"

/// The possible styles a direction can be scaled.
typedef NS_ENUM(NSInteger, WSCoordinateScale) {
    kCoordinateScaleNone = -1,   ///< No coordinate scale transformation.
    kCoordinateScaleLinear,      ///< Linear coordinate scale transformation.
    kCoordinateScaleLogarithmic, ///< Logarithmic scale.
    kCoordinateScaleCustom       ///< Custom transformation, provided by consumer via @p WSCoordinateTransform protocol.
};

/// This class implements a coordinate scale model. It basically
/// defines a map between the coordinate system of the data model and
/// a linear model which usually corresponds to the bounds on screen.
/// It defines the origin, scale function and associated parameters
/// needed to transform from the data model to screen coordinates. A
/// single @p WSCoordinate class describes just one axis, so typically
/// any @p WSPlotController class needs two @p WSCoordinate to
/// describe both X- and Y-dependencies.
///
/// Starting with PowerPlot v1.4, minimum and maximum ranges for pinch
/// and pan gestures can be stored in this class. These ranges should
/// only be used with linear coordinate transformations and may yield
/// unexpected results otherwise.
@interface WSCoordinate : NSObject

@property (nonatomic) WSCoordinateDirection direct;  ///< Direction of this coordinate.
@property (nonatomic) WSCoordinateScale coordScale;  ///< Scaling method.
@property (nonatomic) NARange coordRangeD;           ///< Range (in data coordinates).
@property (nonatomic) NAFloat coordOrigin;           ///< Origin (offset), starting point in bounds coordinates.
@property (nonatomic) BOOL inverted;                 ///< Is the current axis inverted?
@property (weak, nonatomic) id<WSCoordinateTransform> customCoord; ///< Custom coordinate transformation.

/** Pinch and pan gesture recognizer limits. */
@property (nonatomic) NARange scrollRangeD; ///< Allowed range for scrolling.
@property (nonatomic) NARange zoomRangeD;   ///< Allowed range for zooming.

/** Return an axis with default parameters (factory method). */
+ (instancetype)coordinate;

/** Return an axis with custom parameters (factory method). */
+ (instancetype)coordinateWithScale:(WSCoordinateScale)cdScale
                           axisMinD:(NAFloat)axMinD
                           axisMaxD:(NAFloat)axMaxD
                           inverted:(BOOL)invert;

/** Initialize the axis with default parameters. */
- (instancetype)init;

/** Initialize the axis with custom parameters. */
- (instancetype)initWithScale:(WSCoordinateScale)cdScale
                     axisMinD:(NAFloat)axMinD
                     axisMaxD:(NAFloat)axMaxD
                     inverted:(BOOL)invert;

/** @brief Transform a data point from data coordinates to bounds
    coordinates.

    This method is of key importance for all plots since the data can
    be in an arbitrary unit system and coordinate scale, but the
    bounds coordinates are given by the view as it appears on the
    device. This transformation handles the details of going from the
    former to the latter. The @p WSCoordinateTransform protocol for
    custom coordinate transformations also has an optional method for
    the reverse transformation.

    @param dataD Input coordinate in data coordinate system.
    @param size Bounds of @p UIView screen (typically either width or
           height).
    @return Coordinate in bounds coordinate system.
 */
- (NAFloat)transformData:(NAFloat)dataD
                    size:(NAFloat)size;

/** @brief Reverse the above transformation.
 
    This method transforms from bounds coordinates to data
    coordinates.  If the resulting data coordinate cannot be obtained
    it will return @p NAN. The coordinate may be unobtainable for
    several reasons - the range of validity is not correct
    (e.g. negative arguments for logarithmic scales) or we have a
    custom transformation which does not implement the optional
    coordinate reversal.
 
    This method is typically needed for interactive touches. Thus, in
    most cases the linear coordinate system transformation is all that
    is needed.
 
    @param bound Input coordinate in bounds coordinate system.
    @param size Bounds of @p UIView screen (typically either width or
           height).
    @return Coordinate in data coordinate system.
 */
- (NAFloat)transformBounds:(NAFloat)bound
                      size:(NAFloat)size;

@end
