typealias ProductionAmounts = (desiredAmount: Double, actualAmount: Double)

func + (lhs: ProductionAmounts, rhs: ProductionAmounts) -> ProductionAmounts {
    (lhs.desiredAmount + rhs.desiredAmount, lhs.actualAmount + rhs.actualAmount)
}

func += (lhs: inout ProductionAmounts, rhs: ProductionAmounts) {
    lhs = lhs + rhs
}
