import SHModels

extension Category {
    init(fromID id: String) throws {
        self = switch id {
            // Parts
        case Self.special.id: .special
        case Self.ores.id: .ores
        case Self.fuels.id: .fuels
        case Self.aliens.id: .aliens
        case Self.powerSlugs.id: .powerSlugs
        case Self.fluids.id: .fluids
        case Self.gases.id: .gases
        case Self.ingots.id: .ingots
        case Self.standardParts.id: .standardParts
        case Self.electronics.id: .electronics
        case Self.minerals.id: .minerals
        case Self.biomass.id: .biomass
        case Self.powerShards.id: .powerShards
        case Self.industrialParts.id: .industrialParts
        case Self.consumed.id: .consumed
        case Self.communications.id: .communications
        case Self.containers.id: .containers
        case Self.oilProducts.id: .oilProducts
        case Self.nuclear.id: .nuclear
        case Self.spaceElevatorParts.id: .spaceElevatorParts
        case Self.ficsmas.id: .ficsmas
        case Self.quantumTechnology.id: .quantumTechnology
            
            // Equipment
        case Self.head.id: .head
        case Self.back.id: .back
        case Self.body.id: .body
        case Self.hands.id: .hands
        case Self.legs.id: .legs
            
            // Buildings
        case Self.awesomeBonusProgram.id: .awesomeBonusProgram
        case Self.fluidExtractors.id: .fluidExtractors
        case Self.manufacturers.id: .manufacturers
        case Self.miners.id: .miners
        case Self.smelters.id: .smelters
        case Self.workstations.id: .workstations
        case Self.generators.id: .generators
        case Self.powerPoles.id: .powerPoles
        case Self.wallOutlets.id: .wallOutlets
        case Self.conveyorBelts.id: .conveyorBelts
        case Self.conveyorLifts.id: .conveyorLifts
        case Self.conveyorSupports.id: .conveyorSupports
        case Self.pipelineSupports.id: .pipelineSupports
        case Self.pipelines.id: .pipelines
        case Self.sorting.id: .sorting
        case Self.signs.id: .signs
        case Self.attachments.id: .attachments
        case Self.lights.id: .lights
        case Self.storage.id: .storage
        case Self.towers.id: .towers
        case Self.walkways.id: .walkways
        case Self.catwalks.id: .catwalks
        case Self.conveyorConnections.id: .conveyorConnections
        case Self.doors.id: .doors
        case Self.walls.id: .walls
        case Self.windows.id: .windows
        case Self.foundations.id: .foundations
        case Self.quaterPipes.id: .quaterPipes
        case Self.ramps.id: .ramps
        case Self.rampsInverted.id: .rampsInverted
        case Self.hypertubes.id: .hypertubes
        case Self.jumpPads.id: .jumpPads
        case Self.vehicleTransport.id: .vehicleTransport
        case Self.railwayTransport.id: .railwayTransport
        case Self.pillars.id: .pillars
        case Self.beams.id: .beams
        case Self.roofs.id: .roofs
        case Self.frames.id: .frames
        case Self.rampWalls.id: .rampWalls
        case Self.invertedRampWalls.id: .invertedRampWalls
        case Self.tiltedWalls.id: .tiltedWalls
            
        default: throw Error.invalidID(id)
        }
    }
}

private extension Category {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Category with ID '\(id)'"
            }
        }
    }
}

