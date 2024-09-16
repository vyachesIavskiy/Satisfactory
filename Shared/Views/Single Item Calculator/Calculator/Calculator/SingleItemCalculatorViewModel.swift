import SwiftUI
import TipKit
import SHModels
import SHSettings
import SHSingleItemCalculator

@Observable
final class SingleItemCalculatorViewModel {
    // MARK: Observed
    var outputItemViewModels = [SingleItemCalculatorItemViewModel]()
    var modalNavigationState: ModalNavigationState?
    var showingUnsavedConfirmationDialog = false
    var canBeDismissedWithoutSaving = true
    var dismissAfterProductionDeletion = false
    
    @MainActor
    private var byproductSelectionState: ByproductSelectionState? {
        didSet {
            buildOutputItemViewModels()
        }
    }
    
    // MARK: Ignored
    @ObservationIgnored
    private var pins: Pins
    
    @ObservationIgnored
    private var settings: SHSettings.Settings
    
    @ObservationIgnored
    private var explicitlyDeletedPartIDs = Set<String>()
    
    @ObservationIgnored
    private var calculator: SingleItemCalculator
    
    let autoSelectSingleRecipeTip: AutoSelectSingleRecipeTip
    let autoSelectSinglePinnedRecipeTip: AutoSelectSinglePinnedRecipeTip
    
    private let shouldDismissIfDeleted: Bool
    
    @ObservationIgnored
    var amount: Double {
        didSet {
            canBeDismissedWithoutSaving = false
        }
    }
    
    var part: Part {
        calculator.part
    }
    
    @MainActor
    var selectingByproduct: Bool {
        byproductSelectionState != nil
    }
    
    var hasSavedProduction: Bool {
        calculator.hasSavedProduction
    }
    
    var navigationTitle: String {
        if hasSavedProduction {
            calculator.production.name
        } else {
            part.localizedName
        }
    }
    
    var saveProductionTitle: LocalizedStringKey {
        if hasSavedProduction {
            "general-edit"
        } else {
            "general-save"
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    // MARK: Init
    convenience init(part: Part, recipe: Recipe) {
        let calculator = SingleItemCalculator(part: part)
        self.init(calculator: calculator, shouldDismissIfDeleted: false)
        
        addInitialRecipe(recipe)
    }
    
    convenience init(production: SingleItemProduction) {
        let calculator = SingleItemCalculator(production: production)
        self.init(calculator: calculator, shouldDismissIfDeleted: true)
                
        update()
    }
    
    private init(calculator: SingleItemCalculator, shouldDismissIfDeleted: Bool) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        self.calculator = calculator
        amount = calculator.amount
        pins = storageService.pins()
        settings = settingsService.settings
        autoSelectSingleRecipeTip = AutoSelectSingleRecipeTip(part: calculator.part)
        autoSelectSinglePinnedRecipeTip = AutoSelectSinglePinnedRecipeTip(part: calculator.part)
        self.shouldDismissIfDeleted = shouldDismissIfDeleted
    }
    
    // MARK: -
    
    func addRecipe(_ recipe: Recipe, to part: Part) {
        calculator.addRecipe(recipe, to: part)
        addAutoSelectedRecipes(from: recipe)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    func moveItems(indexSet: IndexSet, at position: Int) {
//        production.moveInputItems(from: indexSet, to: position)
    }
    
    func adjustNewAmount() {
        amount = max(amount, 0.1)
    }
    
    func editProduction(onSave: (() -> Void)? = nil) {
        let mode = if hasSavedProduction {
            EditProductionViewModel.Mode.edit
        } else {
            EditProductionViewModel.Mode.new
        }
        let production = Production.singleItem(calculator.production)
        
        let viewModel = EditProductionViewModel(mode, production: production) { [weak self] savedProduction in
            guard let self else { return }
            
            calculator.save()
            calculator.production.name = savedProduction.name
            canBeDismissedWithoutSaving = true
            onSave?()
        } onDelete: { [weak self] in
            guard let self else { return }
            
            if shouldDismissIfDeleted {
                dismissAfterProductionDeletion = true
            } else {
                calculator.deleteSavedProduction()
            }
        }
        
        modalNavigationState = .editProduction(viewModel: viewModel)
    }
    
    func saveProduction() {
        calculator.save()
        canBeDismissedWithoutSaving = true
    }
    
    @MainActor
    func cancelByproductSelection() {
        byproductSelectionState = nil
    }
    
    // MARK: Update
    func update() {
        calculator.amount = amount
        calculator.update()
        
        Task { @MainActor [weak self] in
            self?.buildOutputItemViewModels()
        }
    }
    
    func showStatistics() {
        var productionToShow = calculator.production
        if !hasSavedProduction {
            productionToShow.name = part.localizedName
        }
        modalNavigationState = .statistics(viewModel: StatisticsViewModel(production: .singleItem(productionToShow)))
    }
}

// MARK: Hashable
extension SingleItemCalculatorViewModel: Hashable {
    static func == (lhs: SingleItemCalculatorViewModel, rhs: SingleItemCalculatorViewModel) -> Bool {
        lhs.calculator.production == rhs.calculator.production
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(calculator.production)
    }
}

// MARK: Private
private extension SingleItemCalculatorViewModel {
    func addInitialRecipe(_ recipe: Recipe) {
        calculator.amount = recipe.amountPerMinute(for: recipe.output)
        amount = calculator.amount
        calculator.addRecipe(recipe, to: part)
        addAutoSelectedRecipes(from: recipe)
        update()
        
        // Update this value since it was reset
        canBeDismissedWithoutSaving = true
    }
    
    // MARK: Auto-selection recipes
    func addAutoSelectedRecipes(from recipe: Recipe) {
        let addSingleRecipe = settings.autoSelectSingleRecipe
        let addPinnedRecipe = settings.autoSelectSinglePinnedRecipe
        
        guard addSingleRecipe || addPinnedRecipe else { return }
        
        logger.info("Auto-select recipes: recipe=\(recipe.localizedName), auto-select single=\(addSingleRecipe), auto-select pinned=\(addPinnedRecipe)")
        
        var recipesToCheck = [recipe]
        var recipesToAdd = [(Part, Recipe)]()
        while !recipesToCheck.isEmpty {
            for recipe in recipesToCheck {
                for input in recipe.inputs {
                    guard
                        !calculator.production.inputParts.contains(part: input.part),
                        !explicitlyDeletedPartIDs.contains(input.part.id),
                        !input.part.isNaturalResource
                    else { continue }
                    
                    let inputRecipes = storageService.recipes(for: input.part, as: [.output, .byproduct])
                    let pinnedRecipes = inputRecipes.filter(storageService.isPinned(_:))
                    
                    if addSingleRecipe, inputRecipes.count == 1, !inputRecipes[0].id.contains("packaged") {
                        logger.info("Auto-select single recipe: part=\(input.part.localizedName), recipe=\(inputRecipes[0].localizedName)")
                        recipesToAdd.append((input.part, inputRecipes[0]))
                        if !recipesToCheck.contains(where: { $0.id == inputRecipes[0].id }) {
                            recipesToCheck.append(inputRecipes[0])
                        }
                    } else if addPinnedRecipe, pinnedRecipes.count == 1, !pinnedRecipes[0].id.contains("packaged") {
                        logger.info("Auto-select single pinned recipe: part=\(input.part.localizedName), recipe=\(pinnedRecipes[0].localizedName)")
                        recipesToAdd.append((input.part, pinnedRecipes[0]))
                        if !recipesToCheck.contains(where: { $0.id == pinnedRecipes[0].id }) {
                            recipesToCheck.append(pinnedRecipes[0])
                        }
                    }
                }
                recipesToCheck.removeFirst()
            }
        }
        
        for (part, recipe) in recipesToAdd {
            calculator.addRecipe(recipe, to: part)
        }
        
        calculator.update()
    }
    
//    func addInputRecipesIfNeeded() {
//        let addSingleRecipe = settings.autoSelectSingleRecipe
//        let addPinnedRecipe = settings.autoSelectSinglePinnedRecipe
//        
//        guard addSingleRecipe || addPinnedRecipe else { return }
//        
//        for inputPart in calculator.production.inputParts {
//            for recipe in inputPart.recipes {
//                let inputIngredientParts = recipe.recipe.inputs.map(\.part)
//                
//                for inputPart in inputIngredientParts {
//                    guard
//                        !calculator.production.inputParts.contains(part: inputPart),
//                        !explicitlyDeletedPartIDs.contains(inputPart.id)
//                    else { continue }
//                    
//                    if addSingleRecipe, !inputPart.isNaturalResource {
//                        let recipes = storageService.recipes(for: inputPart, as: [.output, .byproduct])
//                        if
//                            recipes.count == 1,
//                            let recipe = recipes.first,
//                            !recipe.id.contains("packaged")
//                        {
//                            calculator.addRecipe(recipe, to: inputPart)
//                        }
//                    }
//                    
//                    if addPinnedRecipe, !inputPart.isNaturalResource {
//                        let pinnedRecipeIDs = storageService.pinnedRecipeIDs(for: inputPart, as: [.output, .byproduct])
//                        if
//                            pinnedRecipeIDs.count == 1,
//                            let recipe = pinnedRecipeIDs.first.flatMap(storageService.recipe(id:)),
//                            !recipe.id.contains("packaged")
//                        {
//                            calculator.addRecipe(recipe, to: inputPart)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    // MARK: Can perform actions
    @MainActor
    func canAdjustPart(_ outputItem: SingleItemCalculator.OutputPart) -> Bool {
        byproductSelectionState == nil &&
        (outputItem.part != part ||
        storageService.recipes(for: outputItem.part, as: [.output, .byproduct]).count > 1)
    }
    
    func canRemovePart(_ part: Part) -> Bool {
        self.part != part
    }
    
    @MainActor
    func canSelectRecipe(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        byproductSelectionState == nil &&
        !calculator.production.inputParts.contains(part: input.part) &&
        !storageService.recipes(for: input.part, as: [.output, .byproduct]).isEmpty
    }
    
    @MainActor
    func canSelectByproductProducer(byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        // If producing recipe is not yet selected
        byproductSelectionState?.producingRecipe == nil &&
        
        // If production has at least one input with the same item
        calculator.outputRecipesContains {
            !calculator.hasConsumer(byproduct.part, recipe: $0.recipe) &&
            $0.inputs.contains { $0.part == byproduct.part }
        }
    }
    
    @MainActor
    func canUnselectByproductProducer(
        byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
        recipe: Recipe
    ) -> Bool {
        calculator.hasProducer(byproduct.part, recipe: recipe)
    }
    
    @MainActor
    func canSelectByproductConsumer(input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        // If consuming recipe is not yet selected
        byproductSelectionState?.consumingRecipe == nil &&
        
        calculator.outputRecipesContains {
            !calculator.hasProducer(input.part, recipe: $0.recipe) &&
            $0.byproducts.contains { $0.part == input.part }
        }
    }
    
    @MainActor
    func canUnselectByproductConsumer(
        input: SingleItemCalculator.OutputRecipe.InputIngredient,
        recipe: Recipe
    ) -> Bool {
        calculator.hasConsumer(input.part, recipe: recipe)
    }
    
    // MARK: Perform actions
    func adjustPart(_ outputPart: SingleItemCalculator.OutputPart) {
        autoSelectSingleRecipeTip.invalidate(reason: .actionPerformed)
        autoSelectSinglePinnedRecipeTip.invalidate(reason: .actionPerformed)
        modalNavigationState = .adjustItem(
            viewModel: SingleItemCalculatorItemAdjustmentViewModel(
                part: outputPart,
                excludeRecipesForParts: calculator.production.inputParts.map(\.part),
                allowDeletion: outputPart.part != part
            ) { [weak self] outputPart in
                guard let self else { return }
                
                if outputPart.recipes.isEmpty {
                    calculator.removeInputItem(outputPart.part)
                    explicitlyDeletedPartIDs.insert(outputPart.part.id)
                } else {
                    calculator.updateInputPart(outputPart)
                }
                
                modalNavigationState = nil
                update()
            }
        )
    }
    
    func removePart(_ part: Part) {
        autoSelectSingleRecipeTip.invalidate(reason: .actionPerformed)
        autoSelectSinglePinnedRecipeTip.invalidate(reason: .actionPerformed)
        calculator.removeInputItem(part)
        explicitlyDeletedPartIDs.insert(part.id)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    @MainActor
    func selectRecipe(for ingredient: SingleItemCalculator.OutputRecipe.InputIngredient) {
        autoSelectSingleRecipeTip.invalidate(reason: .actionPerformed)
        autoSelectSinglePinnedRecipeTip.invalidate(reason: .actionPerformed)
        let viewModel = SingleItemCalculatorInitialRecipeSelectionViewModel(
            part: ingredient.part,
            excludeRecipesForParts: calculator.production.inputParts.map(\.part)
        ) { [weak self] recipe in
            guard let self else { return }
            
            modalNavigationState = nil
            addRecipe(recipe, to: ingredient.part)
            update()
        }
        
        modalNavigationState = .selectInitialRecipeForItem(viewModel: viewModel)
    }
    
    @MainActor
    func selectByproductProducer(byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient, recipe: Recipe) {
        if byproductSelectionState == nil {
            byproductSelectionState = ByproductSelectionState(
                part: byproduct.part,
                producingRecipe: recipe
            )
        } else {
            byproductSelectionState?.producingRecipe = recipe
        }
        
        checkByproductSelectionState()
    }
    
    @MainActor
    func unselectByproductProducer(byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient, recipe: Recipe) {
        calculator.removeProducer(recipe, for: byproduct.part)
        
        update()
    }
    
    @MainActor
    func selectByproductConsumer(input: SingleItemCalculator.OutputRecipe.InputIngredient, recipe: Recipe) {
        if byproductSelectionState == nil {
            byproductSelectionState = ByproductSelectionState(
                part: input.part,
                consumingRecipe: recipe
            )
        } else {
            byproductSelectionState?.consumingRecipe = recipe
        }
        
        checkByproductSelectionState()
    }
    
    @MainActor
    func unselectByproductConsumer(input: SingleItemCalculator.OutputRecipe.InputIngredient, recipe: Recipe) {
        calculator.removeConsumer(recipe, for: input.part)
        
        update()
    }
    
    @MainActor
    func checkByproductSelectionState() {
        guard
            let part = byproductSelectionState?.part,
            let producingRecipe = byproductSelectionState?.producingRecipe,
            let consumingRecipe = byproductSelectionState?.consumingRecipe
        else { return }
        
        byproductSelectionState = nil
        
        calculator.addByproduct(part, producer: producingRecipe, consumer: consumingRecipe)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    // MARK: ViewModels
    @MainActor
    func buildOutputItemViewModels() {
        outputItemViewModels = calculator.outputParts.map { outputPart in
            SingleItemCalculatorItemViewModel(
                part: outputPart,
                byproductSelectionState: byproductSelectionState,
                canPerformAction: { [weak self] action in
                    guard let self else { return false }
                    
                    return switch action {
                    case let .adjust(part):
                        canAdjustPart(part)
                        
                    case let .removePart(part):
                        canRemovePart(part)
                        
                    case let .selectRecipeForInput(input):
                        canSelectRecipe(for: input)
                        
                    case let .selectByproductProducer(byproduct, _):
                        canSelectByproductProducer(byproduct: byproduct)
                        
                    case let .unselectByproductProducer(byproduct, recipe):
                        canUnselectByproductProducer(byproduct: byproduct, recipe: recipe)
                        
                    case let .selectByproductConsumer(input, _):
                        canSelectByproductConsumer(input: input)
                        
                    case let .unselectByproductConsumer(input, recipe):
                        canUnselectByproductConsumer(input: input, recipe: recipe)
                    }
                },
                performAction: { [weak self] action in
                    guard let self else { return }
                    
                    switch action {
                    case let .adjust(part):
                        adjustPart(part)
                        
                    case let .removePart(part):
                        removePart(part)
                        
                    case let .selectRecipeForInput(input):
                        selectRecipe(for: input)
                        
                    case let .selectByproductProducer(byproduct, recipe):
                        selectByproductProducer(byproduct: byproduct, recipe: recipe)
                        
                    case let .unselectByproductProducer(byproduct, recipe):
                        unselectByproductProducer(byproduct: byproduct, recipe: recipe)
                        
                    case let .selectByproductConsumer(input, recipe):
                        selectByproductConsumer(input: input, recipe: recipe)
                        
                    case let .unselectByproductConsumer(input, recipe):
                        unselectByproductConsumer(input: input, recipe: recipe)
                    }
                }
            )
        }
    }
}

// MARK: Action
extension SingleItemCalculatorViewModel {
    enum Action {
        case adjust(SingleItemCalculator.OutputPart)
        case removePart(Part)
        case selectRecipeForInput(SingleItemCalculator.OutputRecipe.InputIngredient)
        case selectByproductProducer(
            byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
            recipe: Recipe
        )
        case unselectByproductProducer(
            byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
            recipe: Recipe
        )
        case selectByproductConsumer(
            input: SingleItemCalculator.OutputRecipe.InputIngredient,
            recipe: Recipe
        )
        case unselectByproductConsumer(
            input: SingleItemCalculator.OutputRecipe.InputIngredient,
            recipe: Recipe
        )
    }
}

// MARK: ModalNavigationState
extension SingleItemCalculatorViewModel {
    enum ModalNavigationState: Identifiable {
        case selectInitialRecipeForItem(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel)
        case adjustItem(viewModel: SingleItemCalculatorItemAdjustmentViewModel)
        case editProduction(viewModel: EditProductionViewModel)
        case statistics(viewModel: StatisticsViewModel)
        
        var id: String {
            switch self {
            case let .selectInitialRecipeForItem(viewModel): viewModel.part.id
            case let .adjustItem(viewModel): viewModel.id.uuidString
            case let .editProduction(viewModel): viewModel.id.uuidString
            case let .statistics(viewModel): viewModel.id
            }
        }
    }
}

// MARK: ByproductSelectionState
extension SingleItemCalculatorViewModel {
    struct ByproductSelectionState {
        let part: Part
        var producingRecipe: Recipe?
        var consumingRecipe: Recipe?
    }
}

// MARK: Tips
extension SingleItemCalculatorViewModel {
    struct AutoSelectSingleRecipeTip: Tip {
        @Parameter
        static var shouldDisplay: Bool = false
        
        let part: Part
        
        var title: Text {
            Text("single-item-production-tip-auto-select-single-recipe-title")
        }
        
        var message: Text? {
            Text("single-item-production-tip-auto-select-single-recipe-message-\(part.localizedName)")
        }
        
        var rules: [Rule] {
            #Rule(Self.$shouldDisplay) {
                $0 == true
            }
        }
        
        var options: [any TipOption] {
            Tips.MaxDisplayCount(1)
        }
    }
    
    struct AutoSelectSinglePinnedRecipeTip: Tip {
        @Parameter
        static var shouldDisplay: Bool = false
        
        let part: Part
        
        var title: Text {
            Text("single-item-production-tip-auto-select-single-pinned-recipe-title")
        }
        
        var message: Text? {
            Text("single-item-production-tip-auto-select-single-pinned-recipe-message-\(part.localizedName)")
        }
        
        var rules: [Rule] {
            #Rule(Self.$shouldDisplay) {
                $0 == true
            }
        }
        
        var options: [any TipOption] {
            Tips.MaxDisplayCount(1)
        }
    }
}
