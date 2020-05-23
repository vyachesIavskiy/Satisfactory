import UIKit

// MARK: - Layout helpers
public extension UIView {
    // MARK: - Private helper funcs

    // MARK: - Anchors
    @discardableResult
    private func constraint<Axis>(myAnchor: NSLayoutAnchor<Axis>,
                                  equalTo anchor: NSLayoutAnchor<Axis>,
                                  constant: CGFloat = 0,
                                  priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint<Axis>(myAnchor: NSLayoutAnchor<Axis>,
                                  greaterThanOrEqualTo anchor: NSLayoutAnchor<Axis>,
                                  constant: CGFloat = 0,
                                  priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint<Axis>(myAnchor: NSLayoutAnchor<Axis>,
                                  lessThanOrEqualTo anchor: NSLayoutAnchor<Axis>,
                                  constant: CGFloat = 0,
                                  priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - Dimensions
    @discardableResult
    private func constraint(myDimension: NSLayoutDimension,
                            equalTo dimension: NSLayoutDimension,
                            multiplier: CGFloat = 1,
                            constant: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myDimension.constraint(equalTo: dimension, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint(myDimension: NSLayoutDimension,
                            greaterThanOrEqualTo dimension: NSLayoutDimension,
                            multiplier: CGFloat = 1,
                            constant: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myDimension.constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint(myDimension: NSLayoutDimension,
                            lessThanOrEqualTo dimension: NSLayoutDimension,
                            multiplier: CGFloat = 1,
                            constant: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myDimension.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint(myDimension: NSLayoutDimension,
                            equalTo constant: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myDimension.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint(myDimension: NSLayoutDimension,
                            greaterThanOrEqualTo constant: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myDimension.constraint(greaterThanOrEqualToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    private func constraint(myDimension: NSLayoutDimension,
                            lessThanOrEqualTo constant: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = myDimension.constraint(lessThanOrEqualToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - Basic funcs

    // MARK: - Edges

    // MARK: - Top
    @discardableResult
    func top(equalTo anchor: NSLayoutYAxisAnchor,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: topAnchor, equalTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func top(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: topAnchor, greaterThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func top(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: topAnchor, lessThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    // MARK: - Leading
    @discardableResult
    func leading(equalTo anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: leadingAnchor, equalTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func leading(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: leadingAnchor, greaterThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func leading(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: leadingAnchor, lessThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    // MARK: - Bottom
    @discardableResult
    func bottom(equalTo anchor: NSLayoutYAxisAnchor,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: bottomAnchor, equalTo: anchor, constant: -constant, priority: priority)
    }

    @discardableResult
    func bottom(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: bottomAnchor, greaterThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }

    @discardableResult
    func bottom(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: bottomAnchor, lessThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }

    // MARK: - Trailing
    @discardableResult
    func trailing(equalTo anchor: NSLayoutXAxisAnchor,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: trailingAnchor, equalTo: anchor, constant: -constant, priority: priority)
    }

    @discardableResult
    func trailing(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: trailingAnchor, greaterThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }

    @discardableResult
    func trailing(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: trailingAnchor, lessThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }
    
    // MARK: - First Baseline
    @discardableResult
    func firstBaseline(equalTo anchor: NSLayoutYAxisAnchor,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: firstBaselineAnchor, equalTo: anchor, constant: constant, priority: priority)
    }
    
    @discardableResult
    func firstBaseline(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: firstBaselineAnchor, greaterThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }
    
    @discardableResult
    func firstBaseline(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: firstBaselineAnchor, lessThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }
    
    // MARK: - Last Baseline
    @discardableResult
    func lastBaseline(equalTo anchor: NSLayoutYAxisAnchor,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: lastBaselineAnchor, equalTo: anchor, constant: constant, priority: priority)
    }
    
    @discardableResult
    func lastBaseline(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: lastBaselineAnchor, greaterThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }
    
    @discardableResult
    func lastBaseline(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: lastBaselineAnchor, lessThanOrEqualTo: anchor, constant: -constant, priority: priority)
    }

    // MARK: - Dimensions

    // MARK: - Width
    @discardableResult
    func width(equalTo anchor: NSLayoutDimension,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: widthAnchor,
                   equalTo: anchor,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority)
    }

    @discardableResult
    func width(greaterThanOrEqualTo anchor: NSLayoutDimension,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: widthAnchor,
                   greaterThanOrEqualTo: anchor,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority)
    }

    @discardableResult
    func width(lessThanOrEqualTo anchor: NSLayoutDimension,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: widthAnchor,
                   lessThanOrEqualTo: anchor,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority)
    }

    @discardableResult
    func width(equalTo constant: CGFloat,
               priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: widthAnchor, equalTo: constant, priority: priority)
    }

    @discardableResult
    func width(greaterThanOrEqualTo constant: CGFloat,
               priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: widthAnchor, greaterThanOrEqualTo: constant, priority: priority)
    }

    @discardableResult
    func width(lessThanOrEqualTo constant: CGFloat,
               priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: widthAnchor, lessThanOrEqualTo: constant, priority: priority)
    }

    // MARK: - Height
    @discardableResult
    func height(equalTo anchor: NSLayoutDimension,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: heightAnchor,
                   equalTo: anchor,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority)
    }

    @discardableResult
    func height(greaterThanOrEqualTo anchor: NSLayoutDimension,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: heightAnchor,
                   greaterThanOrEqualTo: anchor,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority)
    }

    @discardableResult
    func height(lessThanOrEqualTo anchor: NSLayoutDimension,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: heightAnchor,
                   lessThanOrEqualTo: anchor,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority)
    }

    @discardableResult
    func height(equalTo constant: CGFloat,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: heightAnchor, equalTo: constant, priority: priority)
    }

    @discardableResult
    func height(greaterThanOrEqualTo constant: CGFloat,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: heightAnchor, greaterThanOrEqualTo: constant, priority: priority)
    }

    @discardableResult
    func height(lessThanOrEqualTo constant: CGFloat,
                priority: UILayoutPriority = .required) -> Self {
        constraint(myDimension: heightAnchor, lessThanOrEqualTo: constant, priority: priority)
    }

    // MARK: - Center

    // MARK: - Center X
    @discardableResult
    func centerX(equalTo anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: centerXAnchor, equalTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerX(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: centerXAnchor, greaterThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerX(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: centerXAnchor, lessThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    // MARK: - Center Y
    @discardableResult
    func centerY(equalTo anchor: NSLayoutYAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: centerYAnchor, equalTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerY(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: centerYAnchor, greaterThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerY(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        constraint(myAnchor: centerYAnchor, lessThanOrEqualTo: anchor, constant: constant, priority: priority)
    }

    // MARK: - Basic for View

    // MARK: - Edges

    // MARK: - Top
    @discardableResult
    func top(equalTo view: UIView,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        top(equalTo: view.topAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func top(greaterThanOrEqualTo view: UIView,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        top(greaterThanOrEqualTo: view.topAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func top(lessThanOrEqualTo view: UIView,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        top(lessThanOrEqualTo: view.topAnchor, constant: constant, priority: priority)
    }

    // MARK: - Leading
    @discardableResult
    func leading(equalTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        leading(equalTo: view.leadingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func leading(greaterThanOrEqualTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        leading(greaterThanOrEqualTo: view.leadingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func leading(lessThanOrEqualTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        leading(lessThanOrEqualTo: view.leadingAnchor, constant: constant, priority: priority)
    }

    // MARK: - Bottom
    @discardableResult
    func bottom(equalTo view: UIView,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        bottom(equalTo: view.bottomAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func bottom(greaterThanOrEqualTo view: UIView,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        bottom(greaterThanOrEqualTo: view.bottomAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func bottom(lessThanOrEqualTo view: UIView,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        bottom(lessThanOrEqualTo: view.bottomAnchor, constant: constant, priority: priority)
    }

    // MARK: - Trailing
    @discardableResult
    func trailing(equalTo view: UIView,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        trailing(equalTo: view.trailingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func trailing(greaterThanOrEqualTo view: UIView,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        trailing(greaterThanOrEqualTo: view.trailingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func trailing(lessThanOrEqualTo view: UIView,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        trailing(lessThanOrEqualTo: view.trailingAnchor, constant: constant, priority: priority)
    }
    
    // MARK: - First Baseline
    @discardableResult
    func firstBaseline(equalTo view: UIView,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> Self {
        top(equalTo: view.firstBaselineAnchor, constant: constant, priority: priority)
    }
    
    @discardableResult
    func firstBaseline(greaterThanOrEqualTo view: UIView,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> Self {
        top(greaterThanOrEqualTo: view.firstBaselineAnchor, constant: constant, priority: priority)
    }
    
    @discardableResult
    func firstBaseline(lessThanOrEqualTo view: UIView,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> Self {
        top(lessThanOrEqualTo: view.firstBaselineAnchor, constant: constant, priority: priority)
    }
    
    // MARK: - Last Baseline
    @discardableResult
    func lastBaseline(equalTo view: UIView,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> Self {
        top(equalTo: view.lastBaselineAnchor, constant: constant, priority: priority)
    }
    
    @discardableResult
    func lastBaseline(greaterThanOrEqualTo view: UIView,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> Self {
        top(greaterThanOrEqualTo: view.lastBaselineAnchor, constant: constant, priority: priority)
    }
    
    @discardableResult
    func lastBaseline(lessThanOrEqualTo view: UIView,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> Self {
        top(lessThanOrEqualTo: view.lastBaselineAnchor, constant: constant, priority: priority)
    }

    // MARK: - Dimensions

    // MARK: - Width
    @discardableResult
    func width(equalTo view: UIView,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        width(equalTo: view.widthAnchor,
              multiplier: multiplier,
              constant: constant,
              priority: priority)
    }

    @discardableResult
    func width(greaterThanOrEqualTo view: UIView,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        width(greaterThanOrEqualTo: view.widthAnchor,
              multiplier: multiplier,
              constant: constant,
              priority: priority)
    }

    @discardableResult
    func width(lessThanOrEqualTo view: UIView,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        width(lessThanOrEqualTo: view.widthAnchor,
              multiplier: multiplier,
              constant: constant,
              priority: priority)
    }

    // MARK: - Height
    @discardableResult
    func height(equalTo view: UIView,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        height(equalTo: view.heightAnchor,
               multiplier: multiplier,
               constant: constant,
               priority: priority)
    }

    @discardableResult
    func height(greaterThanOrEqualTo view: UIView,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        height(greaterThanOrEqualTo: view.heightAnchor,
               multiplier: multiplier,
               constant: constant,
               priority: priority)
    }

    @discardableResult
    func height(lessThanOrEqualTo view: UIView,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        height(lessThanOrEqualTo: view.heightAnchor,
               multiplier: multiplier,
               constant: constant,
               priority: priority)
    }

    // MARK: - Center

    // MARK: - Center X
    @discardableResult
    func centerX(equalTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerX(equalTo: view.centerXAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerX(greaterThanOrEqualTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerX(greaterThanOrEqualTo: view.centerXAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerX(lessThanOrEqualTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerX(lessThanOrEqualTo: view.centerXAnchor, constant: constant, priority: priority)
    }

    // MARK: - Center Y
    @discardableResult
    func centerY(equalTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerY(equalTo: view.centerYAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerY(greaterThanOrEqualTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerY(greaterThanOrEqualTo: view.centerYAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerY(lessThanOrEqualTo view: UIView,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerY(lessThanOrEqualTo: view.centerYAnchor, constant: constant, priority: priority)
    }

    // MARK: - Basic for LayoutGuides

    // MARK: - Edges

    // MARK: - Top
    @discardableResult
    func top(equalTo layoutGuide: UILayoutGuide,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        top(equalTo: layoutGuide.topAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func top(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        top(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func top(lessThanOrEqualTo layoutGuide: UILayoutGuide,
             constant: CGFloat = 0,
             priority: UILayoutPriority = .required) -> Self {
        top(lessThanOrEqualTo: layoutGuide.topAnchor, constant: constant, priority: priority)
    }

    // MARK: - Leading
    @discardableResult
    func leading(equalTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        leading(equalTo: layoutGuide.leadingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func leading(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        leading(greaterThanOrEqualTo: layoutGuide.leadingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func leading(lessThanOrEqualTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        leading(lessThanOrEqualTo: layoutGuide.leadingAnchor, constant: constant, priority: priority)
    }

    // MARK: - Bottom
    @discardableResult
    func bottom(equalTo layoutGuide: UILayoutGuide,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        bottom(equalTo: layoutGuide.bottomAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func bottom(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        bottom(greaterThanOrEqualTo: layoutGuide.bottomAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func bottom(lessThanOrEqualTo layoutGuide: UILayoutGuide,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        bottom(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: constant, priority: priority)
    }

    // MARK: - Trailing
    @discardableResult
    func trailing(equalTo layoutGuide: UILayoutGuide,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        trailing(equalTo: layoutGuide.trailingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func trailing(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        trailing(greaterThanOrEqualTo: layoutGuide.trailingAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func trailing(lessThanOrEqualTo layoutGuide: UILayoutGuide,
                  constant: CGFloat = 0,
                  priority: UILayoutPriority = .required) -> Self {
        trailing(lessThanOrEqualTo: layoutGuide.trailingAnchor, constant: constant, priority: priority)
    }

    // MARK: - Dimensions

    // MARK: - Width
    @discardableResult
    func width(equalTo layoutGuide: UILayoutGuide,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        width(equalTo: layoutGuide.widthAnchor,
              multiplier: multiplier,
              constant: constant,
              priority: priority)
    }

    @discardableResult
    func width(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        width(greaterThanOrEqualTo: layoutGuide.widthAnchor,
              multiplier: multiplier,
              constant: constant,
              priority: priority)
    }

    @discardableResult
    func width(lessThanOrEqualTo layoutGuide: UILayoutGuide,
               multiplier: CGFloat = 1,
               constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> Self {
        width(lessThanOrEqualTo: layoutGuide.widthAnchor,
              multiplier: multiplier,
              constant: constant,
              priority: priority)
    }

    // MARK: - Height
    @discardableResult
    func height(equalTo layoutGuide: UILayoutGuide,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        height(equalTo: layoutGuide.heightAnchor,
               multiplier: multiplier,
               constant: constant,
               priority: priority)
    }

    @discardableResult
    func height(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        height(greaterThanOrEqualTo: layoutGuide.heightAnchor,
               multiplier: multiplier,
               constant: constant,
               priority: priority)
    }

    @discardableResult
    func height(lessThanOrEqualTo layoutGuide: UILayoutGuide,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> Self {
        height(lessThanOrEqualTo: layoutGuide.heightAnchor,
               multiplier: multiplier,
               constant: constant,
               priority: priority)
    }

    // MARK: - Center

    // MARK: - Center X
    @discardableResult
    func centerX(equalTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerX(equalTo: layoutGuide.centerXAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerX(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerX(greaterThanOrEqualTo: layoutGuide.centerXAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerX(lessThanOrEqualTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerX(lessThanOrEqualTo: layoutGuide.centerXAnchor, constant: constant, priority: priority)
    }

    // MARK: - Center Y
    @discardableResult
    func centerY(equalTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerY(equalTo: layoutGuide.centerYAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerY(greaterThanOrEqualTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerY(greaterThanOrEqualTo: layoutGuide.centerYAnchor, constant: constant, priority: priority)
    }

    @discardableResult
    func centerY(lessThanOrEqualTo layoutGuide: UILayoutGuide,
                 constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Self {
        centerY(lessThanOrEqualTo: layoutGuide.centerYAnchor, constant: constant, priority: priority)
    }
    
    // MARK: - Add subview
    @discardableResult
    func add(subview: UIView) -> UIView {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        return subview
    }

    // MARK: - Fill
    @discardableResult
    func fill(top topAnchor: NSLayoutYAxisAnchor,
              leading leadingAnchor: NSLayoutXAxisAnchor,
              bottom bottomAnchor: NSLayoutYAxisAnchor,
              trailing trailingAnchor: NSLayoutXAxisAnchor,
              offsets: UIEdgeInsets) -> Self {
        top(equalTo: topAnchor, constant: offsets.top)
            .leading(equalTo: leadingAnchor, constant: offsets.left)
            .bottom(equalTo: bottomAnchor, constant: offsets.bottom)
            .trailing(equalTo: trailingAnchor, constant: offsets.right)
    }

    @discardableResult
    func fill(top: NSLayoutYAxisAnchor,
              leading: NSLayoutXAxisAnchor,
              bottom: NSLayoutYAxisAnchor,
              trailing: NSLayoutXAxisAnchor,
              offset: CGFloat = 0) -> Self {
        fill(top: top,
             leading: leading,
             bottom: bottom,
             trailing: trailing,
             offsets: UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset))
    }

    @discardableResult
    func fill(inside view: UIView, offsets: UIEdgeInsets) -> Self {
        fill(top: view.topAnchor,
             leading: view.leadingAnchor,
             bottom: view.bottomAnchor,
             trailing: view.trailingAnchor,
             offsets: offsets)
    }

    @discardableResult
    func fill(inside view: UIView, offset: CGFloat = 0) -> Self {
        fill(inside: view, offsets: UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset))
    }

    @discardableResult
    func fill(inside layouGuide: UILayoutGuide, offsets: UIEdgeInsets) -> Self {
        fill(top: layouGuide.topAnchor,
             leading: layouGuide.leadingAnchor,
             bottom: layouGuide.bottomAnchor,
             trailing: layouGuide.trailingAnchor,
             offsets: offsets)
    }

    @discardableResult
    func fill(inside layoutGuide: UILayoutGuide, offset: CGFloat = 0) -> Self {
        fill(inside: layoutGuide, offsets: UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset))
    }

    // MARK: - Size
    @discardableResult
    func size(_ size: CGSize) -> Self {
        width(equalTo: size.width).height(equalTo: size.height)
    }

    @discardableResult
    func size(square: CGFloat) -> Self {
        size(CGSize(width: square, height: square))
    }

    // MARK: - Aspect
    @discardableResult
    func aspect(ratio: CGFloat) -> Self {
        width(equalTo: heightAnchor, multiplier: ratio)
    }

    @discardableResult
    func aspect(width: CGFloat, height: CGFloat) -> Self {
        aspect(ratio: width / height)
    }

    @discardableResult
    func square() -> Self {
        aspect(ratio: 1)
    }

    // MARK: - Center
    @discardableResult
    func center(inside view: UIView) -> Self {
        centerX(equalTo: view.centerXAnchor).centerY(equalTo: view.centerYAnchor)
    }

    @discardableResult
    func center(inside layoutGuide: UILayoutGuide) -> Self {
        centerX(equalTo: layoutGuide.centerXAnchor).centerY(equalTo: layoutGuide.centerYAnchor)
    }
}

// MARK: - ReusableId
extension UIView {
    static var reusableId: String { "\(self)" }
}
