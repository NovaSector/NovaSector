// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const conflict_opt_in_status_pref: FeatureChoiced = {
  name: 'Be a Part of the Conflict',
  description:
    'This is for OOC consent to engage in conflict. Pick carefully, as this will affect your policy experience and guide your decisions. \
    You should review the "Conflict Opt-In System" documentation on the wiki to see the current definitions.',
  component: FeatureDropdownInput,
};
