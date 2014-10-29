//
//  WSNode.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 01.11.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSDatum.h"
#import "WSConnectionDelegate.h"

@class WSNodeProperties;

/// Category for a @p WSDatum with @p WSNodeProperties in the @p
/// customData slot. It offers convenience methods to access
/// information specific to nodes.
@interface WSDatum (WSNode)

/** Return an empty node (factory method). */
+ (instancetype)node;

/** @brief Return a node at a point (factory method).
 
    @param point A point on the canvas in data coordinates.
 */
+ (instancetype)nodeAtPoint:(CGPoint)point;

/** Return a node at a point with label text (factory method).
 
    @param point A point on the canvas in data coordinates.
    @param label A string with the node label text.
 */
+ (instancetype)nodeAtPoint:(CGPoint)point
                      label:(NSString *)label;

/** Return a node at a point with text and properties (factory
    method).
 
    @param point A point on the canvas in data coordinates.
    @param label A string with the node label text.
    @param properties A @p WSNodeProperties object with style
           information.
 */
+ (instancetype)nodeAtPoint:(CGPoint)point
                      label:(NSString *)label
                 properties:(WSNodeProperties *)properties;

/** Set the connection delegate for this node.
 
    @param delegate Delegate satisfying the @p WSConnectionDelegate
           protocol.
 */
- (void)setConnectionDelegate:(id<WSConnectionDelegate>)delegate;

/** Return the connection delegate for this node.
 
    @return Delegate satisfying the @p WSConnectionDelegate protocol.
 */
- (id<WSConnectionDelegate>)connectionDelegate;

/** Return the @p WSNodeProperty style information of this node.

    @return The style information.
 */
- (WSNodeProperties *)nodeStyle;

/** Set the @p WSNodeProperty style information on this node.
 
    @param nodeStyle The @p WSNodeProperty style information of this
           node.
 */
- (void)setNodeStyle:(WSNodeProperties *)nodeStyle;

/** Return the label of this node (the annotation of @p WSDatum). */
- (NSString *)nodeLabel;

/** Set the label of this node (the annotation of @p WSDatum). */
- (void)setNodeLabel:(NSString *)label;

/** Return the color of this node (style property). */
- (UIColor *)nodeColor;

/** Set the color of this node (style property). */
- (void)setNodeColor:(UIColor *)color;

/** Get the size property of this node (style property). */
- (CGSize)size;

/** @brief Return the total number of connections of this node.
 
    A circular connection is counted as one. The direction is
    irrelevant.
 
    @note Multiple connections to another node are counted separately.
 */
- (NSUInteger)connectionNumber;

/** @brief Return the total number of directed incoming connections.
 
    The total number of links this node receives. An incoming
    connection is a connection whose direction property is either @p
    kGDirection with this node a as the "to" link, @p
    kGDirectionInverse with this node as the "from" link or a @p
    kGDirectionBoth with this node as either the "to" or the "from"
    link.
 
    @note Multiple connections to another node are counted separately.
 */
- (NSUInteger)incomingNumber;

/** @brief Return the total number of directed outgoing connections.
 
    The total number of links originating from this node. The
    conventions regarding directions are as in @p incomingNumber with
    the meaning of "from" and "to" reversed.
 */
- (NSUInteger)outgoingNumber;

/** @brief Return the total incoming connection strength.
 
    All directed incoming connections this node receives are counted
    and their respective strength is summed up. The conventions
    regarding directions are as in @p incomingNumber.
 */
- (NAFloat)incomingStrength;

/** @brief Return the total outgoing connection strength.
 
    All directed outgoing connections this node has are counted and
    their respectives strength is summed up. The conventions regarding
    directions are as in @p incomingNumber with the meaning of "from"
    and "to" reversed.
 */
- (NAFloat)outgoingStrength;

/** @brief Return the total node connection strength.
 
    Sum of strengths of all directed incoming and outgoing
    connections.
 */
- (NAFloat)nodeActivity;

@end
