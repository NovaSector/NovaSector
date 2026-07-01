// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const conflict_opt_in_status_pref: FeatureChoiced = {
  name: 'Be a Part of the Conflict',
  description:
    'This is your Conflict Opt-In selection, which dictates how you are expected to behave when exposed to antagonism or criminal behavior directed at you or your department. It also dictates how other Crew should handle you when going about their criminal business. \
    These selections are primarily dictated by the Server Policy on the Wiki or Discord references, but loose expectations for each selection are: \
    Passive crew exist as set pieces, excluded from being the focus of major round events or antagonism wherever possible. \
    Involved crew are accepting of confrontation and conflict within the focus and boundaries of roleplaying and story building. \
    Vulnerable crew accept all situations, particularly mechanics and violence, while maintaining protection from Round Removal.  \
    Expendable crew do not care if they live or die. Being gibbed is funny to them and they accept any and all dire consequences which may occur.',
  component: FeatureDropdownInput,
};
