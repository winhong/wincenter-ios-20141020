//
//  WSChartAnimation.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 11/7/11.
//  Copyright (c) 2011-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSChart.h"
#import "NARange.h"

/** Animation options. */
typedef NS_ENUM(NSInteger,WSChartAnimationOptions) {
    kWSChartAnimationOptionCurveNone = -1, ///< Do not perform the animation.
    kWSChartAnimationOptionCurveEaseInOut, ///< Smooth start and finish.
    kWSChartAnimationOptionCurveEaseIn,    ///< Smooth start.
    kWSChartAnimationOptionCurveEaseOut,   ///< Smooth finish.
    kWSChartAnimationOptionCurveLinear     ///< Linear animation.
};

/** Number of updates per second. */
const static NAFloat kWSChartAnimationFPS = 20;

/** Smoothing of ease in/out animations. */
const static NAFloat kWSChartAnimationSmooth = 0.5;

/// @brief Animation methods for @p WSChart.
///
/// This category adds a couple of static methods to @p WSChart that
/// support animations.
///
/// The animatable properties in a @p WSChart are: @p WSData data
/// sources of all instances of @p WSPlotController.  @p
/// WSCoordinate.coordRangeD and @p WSCoordinate.coordOrigin
/// coordinate systems of all instances of @p WSPlotController.
///
/// The number of data points in each @p WSData object in each
/// instance of @p WSPlotController must not be changed during the
/// animation.
///
/// It is strongly recommended against using data bindings during
/// animations as it may cause unpredictable results.
@interface WSChart (WSChartAnimation)

/** @brief Perform a data animation.
 
    This method performs a data animation of a @p WSChart. The
    animatable properties are updated during the transition.
  
    Like a @p UIView animation, this method returns
    immediately. However, the animatable properties are set to
    intermediate values during the animation.  Starting another
    animation while one is currently running results in an
    exception. This can be verified: If the property @p animationTimer
    of @p WSChart is non-nil, then an animation is currently running.
 
    The of number of data points in each @p WSData object in the
    entire chart must remain constant during the animation.
 
    @note The chart's user interaction enabled flag is not changed,
          i.e., the caller is responsible for either manually
          (de-)activating the interaction during the animation or
          handling the interaction properly!  The animations block
          must not change the number of data points in each @p
          WSPlotController!
 
    @param duration The duration of the animation, measured in
           seconds.
    @param delay The delay before the animation starts, measured in
           seconds.
    @param options The animation options of type @p
           WSChartAnimationOptions.
    @param animations A block object containing the changes. Must not
           be @p nil.
    @param context A custom context that will be passed to the
           cycleHandler.
    @param update A block object that is called at every update cycle.
           The parameters are the the progression (which is a float
           ranging from @p 0. to @p 1.) and the context provided by
           the caller.
    @param completion A block object that is called at the completion
           of the animation. It is called with @p YES if the animation
           completed and with @p NO if it was aborted.
 */
- (void)dataAnimateWithDuration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay
                        options:(WSChartAnimationOptions)options
                     animations:(void (^)(void))animations
                        context:(id)context
                         update:(void (^)(NAFloat, id))update
                     completion:(void (^)(BOOL))completion;

/** @brief Perform a data animation.
 
    This method performs a data animation of a @p WSChart. See the
    method @p
    dataAnimateWithDuration:delay:options:animations:context:cycle:completion:
    for the meaning of the parameters.
 */
- (void)dataAnimateWithDuration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay
                        options:(WSChartAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(BOOL))completion;

/** @brief Perform a data animation.

    This method performs a data animation of a @p WSChart. See the
    method @p
    dataAnimateWithDuration:delay:options:animations:context:cycle:completion:
    for the meaning of the parameters.
 */
- (void)dataAnimateWithDuration:(NSTimeInterval)duration
                     animations:(void (^)(void))animations
                     completion:(void (^)(BOOL))completion;

/** @brief Perform a data animation.
 
    This method performs a data animation of a @p WSChart. See the
    method @p
    dataAnimateWithDuration:delay:options:animations:context:cycle:completion:
    for the meaning of the parameters.
 */
- (void)dataAnimateWithDuration:(NSTimeInterval)duration
                     animations:(void (^)(void))animations;

/** @brief Auxilliary method for animation start.
 
    This method triggers the beginning of the animation.
 */
- (void)dataBeginAnimation:(NSTimer *)aTimer;

/** @brief Auxilliary method for animation update.
 
    This auxilliary method performs the chart updates.
 */
- (void)dataUpdateAnimation:(NSTimer *)aTimer;

/** @brief Return the updated progression value.
 
    The progression value is a @p float ranging from @p 0 to @p 1. It
    is computed such that it varies from @p 0 to @p 1 during the
    progress of the animation with a progression that depends on the
    time resolution and the parameter options.
 
    @param iteration Iteration number (varies from @p 0 to @p
           kWSChartAnimationFPS*duration).
    @param duration Duration of the animation in seconds.
    @param options The chart animation options.
 */
+ (NAFloat)progressionAtIteration:(NAFloat)iteration
                         duration:(NSTimeInterval)duration
                          options:(WSChartAnimationOptions)options;

@end
