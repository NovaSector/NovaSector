// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const conflict_opt_in_status_pref: FeatureChoiced = {
  name: 'Be a Part of the Conflict',
  description:
    'This is your Conflict Opt-In selector, which dictates how you are expected to behave when exposed to antagonism. \
    It also guides other players on how to interact with you. \
    These selections are maintained by Server Policy on the Wiki, but loose expectations for each option are: \
    Passive crew should not be targetted by, nor involve themselves with, antagonism. \
    Involved crew accept conflict within the focus and boundaries of roleplaying and story building. \
    Vulnerable crew invite situations that are likely to result in their death while remaining protected from Round Removal.  \
    Expendable crew do not care if, or how, they live or die.',
  component: FeatureDropdownInput,
};
