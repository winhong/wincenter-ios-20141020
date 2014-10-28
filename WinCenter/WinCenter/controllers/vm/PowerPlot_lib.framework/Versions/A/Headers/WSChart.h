//
//  WSChart.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 23.09.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "NARange.h"
#import "WSAxisLocation.h"

@class WSData;
@protocol WSDataDelegate;
@class WSPlotController;
@class WSPlotAxis;

/// @brief Primary view of a chart in PowerPlot.
///
/// This class provides the root view for a chart in PowerPlot. The
/// chart consists of several @p WSPlotController objects. Each @p
/// WSPlotController contains the coordinate system, the data and the
/// views that present its associated data. Each @p WSPlotController
/// has one view and at most one data set. It is possible that it has
/// no data set at all, but each separate visual entity in a chart
/// must have an associated @p WSPlotController.
///
/// The @p WSPlotController objects are stored in a @p NSMutableArray
/// and can thus be added, removed and reordered by the regular means;
/// convenience methods for this purpose are provided and their use is
/// encouraged over direct access to the array of plots.
///
/// The index of the plots plays in important role since their
/// placement reflects the order of the views in the view
/// hierarchy. The higher the index, the higher the plot on the
/// screen, which results in it being drawn in front of all plots with
/// lower index.
///
/// The most convenient way to use this class is to use one of the
/// supplied factory methods that automatically configure and return
/// specific types of charts. This allows to have simple access to
/// default charts with a wide variety of designs.
///
/// Furthermore, a convenient way to generate charts with multiple
/// data sets is to use the @p
/// generateControllerWithData:withPlotClass: method which sets up and
/// configures sub-plots. This approach can be used for example to set
/// up a chart which simultaneously contains lines and bars.
///
/// Starting with PowerPlot v2.0 this class also supports the
/// Objective-C literal notation @p chart[i] to access the @p ith @p
/// WSPlotController in the current stack.
///
/// A common design pattern is to have a single coordinate system that
/// all @p WSPlotController in the chart refer to. In this way,
/// rescaling the coordinates is automatically applied to all plots in
/// the chart. It is possible to have plots with different coordinate
/// axis since each @p WSPlotController has its own coordinate system
/// which is handled by instances of @p WSCoordinate. This feature can
/// be used if one wants to plot data with different units in a single
/// chart. However, the user is ultimately responsible for ensuring
/// consistency and integrity of coordinate axis labels and data when
/// using this feature. For all other use cases, methods for checking
/// and enforcing coordinate axis integrity are provided.
@interface WSChart : UIView

@property (nonatomic, copy) NSString *chartTitle;      ///< Title of the chart.
@property (nonatomic, strong) UIFont *chartTitleFont;  ///< Font of the chart title.
@property (nonatomic, copy) UIColor *chartTitleColor;  ///< Color of the chart title.
@property (nonatomic, strong) id customData;           ///< Slot for custom data.
@property (nonatomic, strong) NSMutableArray *plotSet; ///< An array of @p WSPlotController which will be plotted.
@property (nonatomic, weak) NSTimer *animationTimer;   ///< Timer for running animation (or @p nil if no animation is active).

/** @return The PowerPlot version and license as a @p NSString. */
+ (NSString *)version;
+ (NSString *)license;

/** Reset the chart, discarding any old data. */
- (void)resetChart;

/** Insert and configure a label with the chart title.

    @param newTitle Chart title (@p NSString).
 */
- (void)setChartTitle:(NSString *)newTitle;

/** Add all plots from another chart.
 
    @param chart The chart from which to add all plots.
 */
- (void)addPlotsFromChart:(WSChart *)chart;

/** @brief Create and add a new controller and view to the chart.
 
    This method creates and initializes a new plot controller of class
    @p WSPlotController and its view of class @p aClass (which usually
    will be a subclass of @p WSPlot). The controller is added to this
    @p WSChart instance. The data set is set automatically and the
    coordinate systems are set to the coordinate systems of the first
    plot in this chart instance. If there is none in this instance,
    the coordinate will be allocated and initialized with default
    values. The newly created controller can also be accessed as the
    last element in the @p plotSet of this instance.
 
    This method offers a convenient way to add plots to the chart
    without having to handle all details of the MVC paradigm adopted
    in PowerPlot.
    
    @param dataD The data set to be plotted.
    @param aClass The view class associated with the @p
           WSPlotController, a subclass of @p WSPlot.
    @param frame The frame for the view class.
 */
- (void)generateControllerWithData:(WSData *)dataD
                         plotClass:(Class<NSObject>)aClass
                             frame:(CGRect)frame;

/** Add a new plot.

    @param aPlot The @p WSPlotController instance to be added.
 */
- (void)addPlot:(WSPlotController *)aPlot;

/** Add a new plot at a given index.

    @param aPlot The @p WSPlotController to be inserted.
    @param index Position (layer) in the plot.
 */
- (void)insertPlot:(WSPlotController *)aPlot
           atIndex:(NSUInteger)idx;

/** Replace a plot at a given index.

    @param index Position (layer) in the plot.
    @param aPlot The new @p WSPlotController.
 */
- (void)replacePlotAtIndex:(NSUInteger)idx
                  withPlot:(WSPlotController *)aPlot;

/** Bring a plot to the front.
 
    @param aPlot An existing @p WSPlotController.

    @note If @p aPlot is not found in the list of plot controllers, this
    method does nothing.
 */
- (void)bringPlotToFront:(WSPlotController *)aPlot;

/** Send a plot to the back.
 
    @param aPlot An existing @p WSPlotController.

    @note If @p aPlot is not found in the list of plot controllers, this
    method does nothing.
 */
- (void)sendPlotToBack:(WSPlotController *)aPlot;

/** Get the index of a plot controller in the chart hierarchy.

    @param aPlot An existing @p WSPlotController.

    @note If @p aPlot is not found in the list of plot controllers, this
    method does nothing.
 */
- (NSUInteger)indexOfPlot:(WSPlotController *)aPlot;

/** Remove all plots from current chart. */
- (void)removeAllPlots;

/** Remove a single plot at a given index.
  
    @param index Index of the plot that will be removed.
 */
- (void)removePlotAtIndex:(NSUInteger)idx;

/** Exchange two plots at given indices.
 
    @param idx1 Index of the first plot.
    @param idx2 Index of the second plot.
 */
- (void)exchangePlotAtIndex:(NSUInteger)idx1
            withPlotAtIndex:(NSUInteger)idx2;

/** Return a specific plot at a given index.

    @param index Index of the plot that will be returned.
    @return The @p WSPlotController object.
 */
- (WSPlotController *)plotAtIndex:(NSUInteger)idx;

/** Return the last plot in the chart.
 
    @return The last @p WSPlotController object or @p nil if there is
            none..
 */
- (WSPlotController *)lastPlot;

/** Return the first plot in the chart.

    @return The first @p WSPlotController object or @p nil if there is
            none.
 */
- (WSPlotController *)firstPlot;

/** Return the number of plots (curves) in the chart.

    @return The current number of plots in the chart.
 */
- (NSUInteger)count;

/** Return the first view of a given class type.
 
    @param aClass Class of the requested plot view.
    @return The plot view or @p nil if there is none.
 */
- (id)firstPlotOfClass:(Class)aClass;

/** Return the first @p WSPlotAxis view or @p nil if there is none. */
- (WSPlotAxis *)firstPlotAxis;

/** Return if all plots have identical X-axis scales. 

    @return Result of a scan of all X-axis scales.
 */
- (BOOL)isAxisConsistentX;

/** Return if all plots have identical Y-axis scales.

    @return Result of a scan of all Y-axis scales.
 */
- (BOOL)isAxisConsistentY;

/** Set the coordinate axis X range in all plots.

    @param aRangeD The new range (in data coordinates).
                   @p |rMax-rMin| must be greater than 0.
 */
- (void)scaleAllAxisXD:(NARange)aRangeD;

/** Set the coordinate axis Y range in all plots.

    @param aRangeD The new range (in data coordinates). @p
                   |rMax-rMin| must be greater than 0.
 */
- (void)scaleAllAxisYD:(NARange)aRangeD;

/** @brief Set the X-coordinate range based on the data provided.

    The new range will be a wider -- scaled by the golden ratio --
    than the entire range of X-values of the data provided.
    
    @note This method will examine the data in all plots in the
          current chart that have data associated with them and then
          set all plots in the chart to the new scale!
 */
- (void)autoscaleAllAxisX;

/** @brief Set the Y-coordinate range based on the data provided.
 
    The new range will be a higher -- scaled by the golden ratio --
    than the entire range of Y-values of the data provided.

    @note This method will examine the data in all plots in the
          current chart that have data associated with them and then
          set all plots in the chart to the new scale!
 */
- (void)autoscaleAllAxisY;

/** @brief Set the X-axis location of all plots in bounds coordinates.
 
    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeX property set to @p
          kPreserveBounds. This value keeps the X-axis fixed at bounds
          coordinates upon resize/coordinate transformation.
 */
- (void)setAllAxisLocationX:(NAFloat)aLocation;

/** @brief Set the Y-axis location of all plots in bounds coordinates.
 
    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeY property set to @p
          kPreserveBounds. This value keeps the Y-axis fixed at bounds
          coordinates upon resize/coordinate transformation.
 */
- (void)setAllAxisLocationY:(NAFloat)aLocation;

/** @brief Set X-axis location of all plots in data coordinates.
 
    @note After returning from this method, all plot controllers have
          the axisPreserveOnChangeX property set to
          kPreserveData. This value keeps the X-axis fixed at data
          coordinates upon resize/coordinate transformation.
 */
- (void)setAllAxisLocationXD:(NAFloat)aLocationD;

/** @brief Set Y-axis location of all plots in data coordinates.
 
    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeY property set to @p
          kPreserveData. This value keeps the Y-axis fixed at bounds
          coordinates upon resize/coordinate transformation.
 */
- (void)setAllAxisLocationYD:(NAFloat)aLocationD;

/** @brief Set the X-axis location of all plots to the data coordinate origin.
 
    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeX property set to @p
          kPreserveData. This value keeps the X-axis fixed at data
          coordinates upon resize/coordinate transformation.
 */
- (void)setAllAxisLocationToOriginXD;

/** @brief Set the Y-axis location of all plots to the data coordinate origin.

    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeY property set to @p
          kPreserveData. This value keeps the Y-axis fixed at data
          coordinates upon resize/coordinate transformation.
 */
- (void)setAllAxisLocationToOriginYD;

/** @brief Set X-axis location of all plots to a relative position (0..1).
 
    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeX property set to @p
          kPreserveRelative. This value keeps the X-axis fixed at
          their position relative to the view size upon
          resize/coordinate transformation.
 */
- (void)setAllAxisLocationXRelative:(NAFloat)aLocation;

/** @brief Set Y-axis location of all plots to a relative position (0..1).
 
    @note After returning from this method, all plot controllers have
          the @p axisPreserveOnChangeY property set to @p
          kPreserveRelative. This value keeps the Y-axis fixed at
          position relative to the view size upon resize/coordinate
          transformation.
 */
- (void)setAllAxisLocationYRelative:(NAFloat)aLocation;

/** @brief Set X-axis positioning policy of all plots.
 
    This value is set on the X-axis of all plot controllers and
    handles the way a resize and a coordinate transformation impacts
    the (re-)positioning of the axis location.
 */
- (void)setAllAxisPreserveOnChangeX:(WSAxisLocationPreservationStyle)aStyle;

/** @brief Set X-axis positioning policy of all plots.
 
    This value is set on the Y-axis of all plot controllers and
    handles the way a resize and a coordinate transformation impacts
    the (re-)positioning of the axis location.
 */
- (void)setAllAxisPreserveOnChangeY:(WSAxisLocationPreservationStyle)aStyle;

/** Return the maximum range of the data in all plots.

    The method can be applied to different information contained in
    plot controller objects. The requested piece of information is
    extracted from a @p WSPlotController object using the given
    selector.

    @note If a @p WSPlotController does not respond to the selector,
          the plot is ignored.

    @param dataExtract The selector applied to a @p WSPlotController.
    @return The resulting range is returned.
 */
- (NARange)dataRangeD:(SEL)dataExtract;

/** Return the maximum X-range of the data in all plots.

    @return The resulting maximum range.
 */
- (NARange)dataRangeXD;

/** Return the maximum Y-range of the data in all plots.

    @return The resulting maximum range.
 */
- (NARange)dataRangeYD;

/** Objective-C array literal support. */
- (WSPlotController *)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(WSPlotController *)obj atIndexedSubscript:(NSUInteger)idx;

/** This method will abort a running animation.
 
    The completion handler (if defined) will be called with @p NO.
*/
- (void)abortAnimation;

@end

