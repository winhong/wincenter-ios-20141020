//
//  WSCoordinateTransform.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 08.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

@import UIKit;
#import "NABase.h"

/// Protocol which a coordinate transformation needs to implement.
/// Custom coordinate transformations also need to implement this
/// protocol.
@protocol WSCoordinateTransform <NSObject>

@required

/** Return the coordinate transformation of a value.

    @param valueD Input location in data coordinates. 
    @return Return value in intermediate scheme with range @p [0..1].
 */
- (NAFloat)coordTransform:(NAFloat)valueD;

/** Return axis ticks locations.

    @param aRange Range in which to generate tick locations.
    @param labelNum Number of ticks in input range.
    @return @p NSArray of @p NSNumber with @p float with tick
            locations in data coordinates.
 */
- (NSArray *)tickLocationsWithRange:(NARange)aRange
                             number:(NAFloat)labelNum;

@optional

/** Reverse a coordinate transformation (inverse of transform). */
- (NAFloat)inverseCoordTransform:(NAFloat)value;

/** Return a custom @p NSNumberFormatter for this particular
    transformation.
 */
- (NSNumberFormatter *)coordinateFormatter;

@end
