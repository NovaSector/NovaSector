import { createContext, useContext } from 'react';

import { ServerData } from './types';

export const ServerPrefs = createContext<ServerData | undefined>({
  jobs: {
    departments: {},
    jobs: {},
  },
  names: {
    types: {},
  },
  // NOVA EDIT ADDITION START
  vocals: {
    types: {},
  },
  // NOVA EDIT ADDITION END
  quirks: {
    max_positive_quirks: -1,
    quirk_info: {},
    quirk_blacklist: [],
    points_enabled: false,
  },
  random: {
    randomizable: [],
  },
  loadout: {
    loadout_tabs: [],
  },
  species: {},
});

export function useServerPrefs() {
  return useContext(ServerPrefs);
}
