import 'package:flutter/material.dart';

class PageRouteTransition<T> extends PageRouteBuilder<T> {
  final Widget page;
  
  PageRouteTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _StaticBottomNavigationTransition(
              animation: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
}

class _StaticBottomNavigationTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final double bottomNavHeight = 56.0; // Standard height for bottom navigation bar
  
  const _StaticBottomNavigationTransition({
    required this.animation,
    required this.child,
  });
  
  @override
  Widget build(BuildContext context) {
    const begin = Offset(0.2, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOutCubic;
    
    // Slide animation
    var slideAnimation = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    
    // Scale animation
    final scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: curve,
    ));
    
    // Fade animation
    final fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: curve,
    ));

    // Extract Scaffold to access bottomNavigationBar
    if (child is Scaffold) {
      final scaffold = child as Scaffold;
      final bottomNavigationBar = scaffold.bottomNavigationBar;
      
      // Create content without the bottom navigation
      final content = Scaffold(
        appBar: scaffold.appBar,
        body: scaffold.body,
        floatingActionButton: scaffold.floatingActionButton,
        floatingActionButtonLocation: scaffold.floatingActionButtonLocation,
        floatingActionButtonAnimator: scaffold.floatingActionButtonAnimator,
        drawer: scaffold.drawer,
        endDrawer: scaffold.endDrawer,
        backgroundColor: scaffold.backgroundColor,
      );
      
      // Apply animations only to the content
      return Stack(
        children: [
          // Animate main content
          Positioned.fill(
            bottom: bottomNavigationBar != null ? bottomNavHeight : 0,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SlideTransition(
                  position: animation.drive(slideAnimation),
                  child: content,
                ),
              ),
            ),
          ),
          
          // Static bottom bar
          if (bottomNavigationBar != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: bottomNavHeight,
              child: Material(
                elevation: 8,
                child: bottomNavigationBar,
              ),
            ),
        ],
      );
    }
    
    // Fallback for non-scaffold pages
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: SlideTransition(
          position: animation.drive(slideAnimation),
          child: child,
        ),
      ),
    );
  }
}

// This extension makes it easier to create transitions
extension NavigatorExtension on NavigatorState {
  Future<T?> pushWithTransition<T extends Object?>(Widget page) {
    return push<T>(PageRouteTransition<T>(page: page));
  }
  
  Future<T?> pushReplacementWithTransition<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
    bool maintainState = true,
  }) {
    return pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        maintainState: maintainState,
      ),
      result: result,
    );
  }
  
  Future<T?> pushNamedAndRemoveUntilWithTransition<T extends Object?>(Widget page, RoutePredicate predicate) {
    return pushAndRemoveUntil<T>(
      PageRouteTransition<T>(page: page),
      predicate
    );
  }
} 