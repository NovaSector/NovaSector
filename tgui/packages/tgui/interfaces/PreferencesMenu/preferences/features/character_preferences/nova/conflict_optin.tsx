// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const conflict_opt_in_status_pref: FeatureChoiced = {
  name: 'Be a Part of the Conflict',
  description:
    'This is your Conflict Opt-In selection, which dictates how you are expected to behave when exposed to antagonism or criminal behavior directed at you or your department. It also dictates how other Crew should handle you when going about their criminal business. \
    These selections are primarily dictated by the Server Policy on the Wiki or Discord references, but loose expectations for each selection are: \
    Passive crew should behave non-aggressively or only in direct self defense, and should not be targeted with antagonistic action. They are expected to not interfere with criminal activity or ongoing antagonists, even if it disadvantages them or their department. \
    Involved crew accept confrontation that is unlikely to result in their death, but that may otherwise disadvantage them. They can be targeted for antagonistic action, as can later opts. \
    Vulnerable crew accept conflict that may result in their death. \
    Expendable crew may be used as a target for any conflict or antagonistic action which results in their destruction, total disfigurement, transformation, or otherwise technical removal from the round such as by deep-spacing.',
  component: FeatureDropdownInput,
};
