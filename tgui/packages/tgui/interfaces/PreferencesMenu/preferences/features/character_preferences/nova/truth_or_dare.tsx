// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const accepts_random_td: FeatureChoiced = {
  name: 'Random Truth or Dare Requests',
  description:
    'Opt-in to receiving random Truth or Dare requests from other crew, typically via PDA. This will be shown in the Character Directory and is a great way to meet new people randomly.',
  component: FeatureDropdownInput,
};
