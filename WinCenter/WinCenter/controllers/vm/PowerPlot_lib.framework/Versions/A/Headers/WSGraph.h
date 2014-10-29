//
//  WSGraph.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 28.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSData.h"
#import "WSConnection.h"
#import "WSConnectionDelegate.h"

@class WSData;
@class WSGraphConnections;
@class WSNodeProperties;

/// This class describes a graph consisting of nodes and
/// connections. The nodes are described using the implementation of
/// the @p WSData base class with @p WSNodeProperties in the @p
/// customData slot and the connections are described using the @p
/// WSGraphConnections object.  Any operation that the base class
/// offered will apply to the graph nodes, whereas additional
/// functionality provided by this class will apply either exclusively
/// to the connections or both to the nodes and the connections.
///
/// This class offers a convenient and complete interface to the
/// representation of a graph as a data model and can be extended in
/// functionality for future applications to other use cases requiring
/// graphs.
@interface WSGraph : WSData <NSCopying, NSCoding, NSFastEnumeration, WSConnectionDelegate>

@property (strong) WSGraphConnections *connections; ///< The connections between nodes.

/** Return an empty graph (factory method). */
+ (instancetype)graph;

/** Return a graph with nodes and connections (factory method). */
+ (instancetype)graphWithNodes:(WSData *)nodes
                   connections:(WSGraphConnections *)connections;

/** Initialize an empty graph. */
- (instancetype)init;

/** Initialize the graph with given nodes and connections. */
- (instancetype)initWithNodes:(WSData *)nodes
                  connections:(WSGraphConnections *)connections;

/** Copy a new instance of the custom style to all nodes. */
- (void)setAllNodesTo:(WSNodeProperties *)custom;

/** Add a new node to the end of the list. */
- (void)addNode:(WSDatum *)node;

/** Insert a new node.
 
    @param node The new node.
    @param index Index where the new node is inserted.
 */
- (void)insertNode:(WSDatum *)node
           atIndex:(NSUInteger)index;

/** Replace a node at a given index.
 
    @param index Index where the node is placed.
    @param node The new node.
 */
- (void)replaceNodeAtIndex:(NSUInteger)index
                  withNode:(WSDatum *)node;

/** Remove all nodes. */
- (void)removeAllNodes;

/** Remove an individual node.
 
    @param index Index where the node will be removed.
 */
- (void)removeNodeAtIndex:(NSUInteger)index;

/** Return a specific node at index. */
- (WSDatum *)nodeAtIndex:(NSUInteger)index;

/** Return the total number of connections. */
- (NSUInteger)connectionCount;

/** Add a new connection. */
- (void)addConnection:(WSConnection *)connection;

/** Add a new connection from a to b. */
- (void)addConnectionFrom:(NSUInteger)a
                       to:(NSUInteger)b;

/** Add a new connection from a to b with given strength. */
- (void)addConnectionFrom:(NSUInteger)a
                       to:(NSUInteger)b
                 strength:(NAFloat)s;

/** Add a new connection from a to b with given strength and
    direction.
 */
- (void)addConnectionFrom:(NSUInteger)a
                       to:(NSUInteger)b
                 strength:(NAFloat)s
                direction:(WSGDirection)dir;

/** Remove a single connection. */
- (void)removeConnection:(WSConnection *)connection;

/** Remove all connections between a and b. */
- (void)removeConnectionsBetweenNode:(NSUInteger)a
                             andNode:(NSUInteger)b;

/** Remove all connections. */
- (void)removeAllConnections;

/** Set all node connections to be undirected. */
- (void)removeAllDirections;

/** Set all connections to a given color. */
- (void)colorAllConnections:(UIColor *)color;

/** Set all connections to a given strength. */
- (void)strengthAllConnections:(NAFloat)strength;

/** Get the minimum connection strength. */
- (NAFloat)minimumStrength;

/** Get the maximum connection strength. */
- (NAFloat)maximumStrength;

@end
