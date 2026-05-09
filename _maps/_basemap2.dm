//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files/coyote_bayou/later_backup_nash/CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files/coyote_bayou/later_backup_nash/Dungeons.dmm"
		#include "map_files/coyote_bayou/later_backup_nash/Texarkana_underground.dmm"
		#include "map_files/coyote_bayou/later_backup_nash/Newboston.dmm"
		#include "map_files/coyote_bayou/later_backup_nash/Newboston-Upper.dmm"
	#endif
#endif
