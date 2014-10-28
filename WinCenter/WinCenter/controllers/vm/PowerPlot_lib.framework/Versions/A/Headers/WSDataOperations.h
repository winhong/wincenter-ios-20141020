//
//  WSDataOperations.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 06.08.11.
//  Copyright 2011-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSData.h"

@class WSDatum;

// Define the block types used in the operations.

/// Block which maps an object to a @p WSDatum.
typedef WSDatum* (^mapBlock_t)(const id);

/// Block that compares to @p WSDatum objects, yielding a @p
/// NSComparisonResult.
typedef NSComparisonResult (^sortBlock_t)(WSDatum *, WSDatum *);

/// Block which is used to filter @p WSDatum objects by returning a @p
/// BOOL indicating whether a @p WSDatum matches a condition.
typedef BOOL (^filterBlock_t)(WSDatum *);

/// Block which reduces two @p WSDatum objects to a single one.
typedef WSDatum* (^reduceDatum_t)(WSDatum *, WSDatum *);

/// This category defines a collection of operations on @p WSData
/// objects.
@interface WSData (WSDataOperations)

/** @brief Map a function on a single data set (non-destructive).
 
    The input data object can either be a @p WSData object or an @p
    NSArray of @p WSDatum objects, each of which must have the same
    number of elements.  In the former case (if data is of class @p
    WSData), @p mapBlock is called with @p WSDatum objects. In the
    latter case (if data is of class @p NSArray), @p mapBlock is
    called with an @p NSArray of @p WSDatum objects, taken from the
    respective index of each @p WSData objects, i.e., the array is
    resorted for operation by @p mapBlock.
 
    @param data Input data object, not modified on return.
    @param mapBlock The function to be applied to each @p WSDatum
           object.
    @return A new @p WSData object with @p mapBlock mapped on data.
 */
+ (WSData *)data:(id)data
             map:(mapBlock_t)mapBlock;

/** @brief Map a function on the current data set (destructively).
 
    The function @p mapBlock is applied to each element of the current
    data set. The function must take and return @p WSDatum objects.
 
    @param mapBlock The function to be applied to each @p WSDatum
           object.
 */
- (void)map:(mapBlock_t)mapBlock;

/** @brief Apply a custom reduction operation to the current data set.
 
    A reduction operation is applied to the current data set,
    returning a @p WSDatum object that is obtained by reducing the
    elements of the original set. The operation is non-destructive for
    both the current data set as well as the starting element.
 
    @return A @p WSDatum object containing the result of the full
            reduction.
 */
- (WSDatum *)reduce:(reduceDatum_t)reduceBlock
              start:(WSDatum *)initial;

/** @brief Apply reduction operation 'average' to the current data
    set.
 
    A reduction operation is applied to the current data set,
    returning a @p WSDatum object that contains the averaged X- and
    Y-values of the original set.
 
    @note Errors and correlations are ignored.
 
    @return A @p WSDatum object containing the averaging result.
 */
- (WSDatum *)reduceAverage;

/** @brief Apply reduction operation 'sum' to the current data set.
 
    A reduction operation is applied to the current data set,
    returning a @p WSDatum object that contains the averaged X- and
    Y-values of the original set.
 
    @note Errors and correlations are ignored.
 
    @return A @p WSDatum object containing the sum result.
 */
- (WSDatum *)reduceSum;

/** Return a new @p WSData set, sorted with a custom comparator.
 
    @param comparator Block comparing two instances of @p WSDatum.
    @result A new @p WSData set, sorted according to the comparator.
 */
- (WSData *)sortedDataUsingComparator:(sortBlock_t)comparator;

/** Return a new @p WSData set, filtered with a custom filter.
 
    @param filter Block returning a @p BOOL if this object should be
           used.
    @return A new @p WSData set, filtered according to the block.
 */
- (WSData *)filteredDataUsingFilter:(filterBlock_t)filter;

/** Return an array of floats with the X-values extracted from data
    set.
 
    @note The receiver needs to free the array after use. The length
          of the array needs to be taken from the @p count method.
 */
- (NAFloat *)floatsFromDataX;

/** Return an array of floats with the Y-values extracted from data
    set.
 
    @note The receiver needs to free the array after use. The length
          of the array needs to be taken from the @p count method.
 */
- (NAFloat *)floatsFromDataY;

/** Return the index of the datum that is closest to the given point.
 
    @note If there are no data points in the set, @p -1 is returned.

    @param location Location of a point in the coordinate system of
           the data set.
    @return Index of the point closest to the given index. 
 */
- (NSInteger)datumClosestToLocation:(CGPoint)location;

/** Return the index of the datum closest to the given point within a
    distance.
 
    @note If there are no data points within the distance given, @p -1
          is returned.
 
    @param location Location of a point in the coordinate system of
           the data set.
    @param distance Maximum distance for hit testing.
    @return Index of the point closest to the given index. 
 */
- (NSInteger)datumClosestToLocation:(CGPoint)location
                    maximumDistance:(NAFloat)distance;

/** Return the index of the datum whose X-value is closest to a given
    X-value.
 
    @note If there are no data points in the set, @p -1 is returned.
 
    @param valueX X-value in the coordinate system of the data set.
    @return Index of the point closest to the given index. 
 */
- (NSInteger)datumClosestToValueX:(NAFloat)valueX;

/** Index of datum whose X-value is closest to a given X-value within
    a distance.
 
    @note If there are no data points within the distance given, @p -1
          is returned.
 
    @param valueX X-value in the coordinate system of the data set.
    @param distance Maximum distance for hit testing.
    @return Index of the point closest to the given index. 
 */
- (NSInteger)datumClosestToValueX:(NAFloat)valueX
                  maximumDistance:(NAFloat)distance;

/** Return the index of the datum whose Y-value is closest to a given
    Y-value.
 
    @note If there are no data points in the set, @p -1 is returned.
 
    @param valueY Y-value in the coordinate system of the data set.
    @return Index of the point closest to the given index. 
 */
- (NSInteger)datumClosestToValueY:(NAFloat)valueY;

/** Index of datum whose Y-value is closest to a given Y-value within
    a distance.
 
    @note If there are no data points within the distance given, @p -1
          is returned.
 
    @param valueY Y-value in the coordinate system of the data set.
    @param distance Maximum distance for hit testing.
    @return Index of the point closest to the given index. 
 */
- (NSInteger)datumClosestToValueY:(NAFloat)valueY
                  maximumDistance:(NAFloat)distance;

@end
