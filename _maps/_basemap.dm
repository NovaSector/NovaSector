//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Birdshot\birdshot.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		#include "map_files\NebulaStation\NebulaStation.dmm"
		#include "map_files\wawastation\wawastation.dmm"
		// NOVA EDIT ADDITON START - Compiling our modular maps too!
		#include "map_files\VoidRaptor\VoidRaptor.dmm"
		#include "map_files\NSVBlueshift\Blueshift.dmm"
		#include "map_files\Ouroboros\Ouroboros.dmm"
		#include "map_files\SerenityStation\SerenityStation.dmm"
		#include "map_files\AquaStation\AquaStation.dmm" // Underwater high pop
		#include "map_files\HeskiStation\HeskiStation.dmm" // Underwater low pop
		#include "map_files\NomadStation\NomadStation.dmm" // Space (bunch of ships welded together, such as Interdyne, IRN, NT Vessels and many more!)
		#include "map_files\WaveBreaker\WaveBreaker.dmm" // OCEAN (NOT PLASMALAKE) || Plasmarig Highpop (think of an oil rig on an ocean) || Breathable Atmosphere
		#include "map_files\RustRig\RustRig.dmm" // OCEAN (NOT PLASMALAKE) || Plasmarig Lowpop || May have a retextured gas miner to "Mine" the plasma from the planet || Breathable Atmosphere
		#include "map_files\AlterisStation\AlterisStation.dmm" // OCEAN (NOT PLASMALAKE) || Water Platform Highpop (Like plasma rig but it doesnt mine anything) || Breathable Atmosphere
		#include "map_files\AmmixStation\AmmixStation.dmm" // OCEAN (NOT PLASMALAKE) || Water Platform Lowpop (Like plasma rig but it doesnt mine anything) || Breathable Atmosphere
		#include "map_files\RainStation\RainStation.dmm" // Constantly Raining Planet Highpop || Breathable Atmosphere
		#include "map_files\HeliosStation\HeliosStation.dmm" // Constantly Raining Planet Lowpop || Breathable Atmosphere
		#include "map_files\OasisStation\OasisStation.dmm" // Desert Planet Highpop || Breathable Atmosphere
		#include "map_files\DuneStation\DuneStation.dmm" // Desert Raining Planet Lowpop || Breathable Atmosphere
		// NOVA EDIT END
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
