//
//  WSTicks.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 12.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "NARange.h"

/** Configuration of default ticks appearance (in bounds coordinates). */
#define kMajorTicksLen 10.0
#define kMinorTicksLen 5.0
#define kLabelOffset 3.0

/** Styles a coordinate axis tick label can be drawn. */
typedef NS_ENUM(NSInteger, WSTicksStyle) {
    kTicksNone = -1,           ///< Do not show tick labels.
    kTicksLabels,              ///< Show tick labels at standard location.
    kTicksLabelsInverse,       ///< Show tick labels at reverse side.
    kTicksLabelsSlanted,       ///< Show tick labels slanted at standard location.
    kTicksLabelsSlantedInverse ///< Show tick labels slanted at reverse side.
};

/** Styles a coordinate axis ticks can be drawn. */
typedef NS_ENUM(NSInteger, WSTicksDirection) {
    kTDirectionNone = -1, ///< Do not show axis ticks.
    kTDirectionIn,        ///< Ticks point inwards.
    kTDirectionOut,       ///< Ticks point outwards.
    kTDirectionInOut      ///< Ticks point both ways.
};

/// This class implements the functionality of axis ticks. It handles
/// their locations (in data coordinates), labeling and
/// configuration. It also provides automated algorithms to set some
/// of those parameters.
///
/// With PowerPlot v2.0 this class supports the new collection literal
/// syntax. Using @p tick[i] is equivalent to the @p labelAtIndex
/// method. It is only possible to retrieve the location using this
/// method.
@interface WSTicks : NSObject

@property (nonatomic) WSTicksStyle ticksStyle;                ///< Styles of tick labels on X- and Y-axis.
@property (nonatomic) WSTicksDirection ticksDir;              ///< Direction of tick marks on X- and Y-axis.
@property (nonatomic) NSUInteger minorTicksNum;               ///< Number of minor ticks between major ones.
@property (strong, nonatomic) NSMutableArray *ticksPosD;      ///< Major ticks positions (in data coords).
@property (strong, nonatomic) NSMutableArray *minorTicksPosD; ///< Minor ticks positions (in data coords).
@property (strong, nonatomic) NSMutableArray *labelString;    ///< Tick label strings.
@property (nonatomic) NAFloat majorTicksLen;                  ///< Length of major ticks.
@property (nonatomic) NAFloat minorTicksLen;                  ///< Length of minor ticks.
@property (nonatomic) NAFloat labelOffset;                    ///< Distance between tick end and label start.

/** Return the number of major ticks. */
- (NSUInteger)count;

/** Return the number of minor ticks. */
- (NSUInteger)countMinor;

/** Return the major tick position (in data coords) at index @p i. */
- (NAFloat)tickAtIndex:(NSUInteger)i;

/** Return the label string at index i. */
- (NSString *)labelAtIndex:(NSUInteger)i;

/** Return the minor tick position (in data coords) at index @p i. */
- (NAFloat)minorTickAtIndex:(NSUInteger)i;

/** @brief Set the major and minor tick positions.
 
    The major and minor tick positions are calculated and set. All
    labels are set to empty strings.
 
    @param aRange Coordinate range for tick positions. @p |rMax-rMin|
           must be > 0.
    @param labelNum Number of major ticks. Must be >= 0.
    @param skipFirst Indicates whether the first position at @p rMin
           should be included or skipped.
 */
- (void)autoTicksWithRange:(NARange)aRange
                    number:(NAFloat)labelNum
                 skipFirst:(BOOL)skipFirst;

/** @brief Set the major and minor tick positions using "nice"
    positioning.
 
    The major and minor tick positions are calculated using an
    algorithm based on "Graphics Gems" by Andrew S. Glassner,
    pp. 62. The positions appear using a "nice" positioning method
    which rounds to power of ten multiples of the leading digit. All
    labels are set to empty strings.
 
    @param aRange Coordinate range for tick positions. @p |rMax-rMin|
           must be > 0.
    @param labelNum Number of major ticks. Must be >= 0.
    @return Suggested number of digits for the result labels.
 */
- (NSInteger)autoNiceTicksWithRange:(NARange)aRange
                             number:(NAFloat)labelNum;

/** @brief Set ticks using an array of major tick positions.
 
    Set the major tick positions from the array provided, then compute
    the minor tick positions, set the labels to empty strings.

    @param positions The positions in bounds coordinates.
 */
- (void)ticksWithNumbers:(NSArray *)positions;

/** @brief Set major tick mark positions and labels.
 
    Set ticks and labels using arrays of major tick positions and
    labels. Then compute the minor tick positions and insert
    them. Both arrays need to have the same sizes.

    @param positions The positions in bounds coordinates.
    @param labels The corresponding labels.
 */
- (void)ticksWithNumbers:(NSArray *)positions
                  labels:(NSArray *)labels;

/** Set the tick labels using a default scientific formatter. */
- (void)setTickLabels;

/** Set the tick labels using a default @p NSNumberFormatter style. */
- (void)setTickLabelsWithStyle:(NSNumberFormatterStyle)style;

/** Set the tick labels using a custom formatter. */
- (void)setTickLabelsWithFormatter:(NSNumberFormatter *)formatter;

/** Set the tick labels to strings, and the positions to indexed data
    points.
 */
- (void)setTickLabelsWithStrings:(NSArray *)strings;

/** Objective-C array literal support. */
- (NSString *)objectAtIndexedSubscript:(NSUInteger)idx;

@end
