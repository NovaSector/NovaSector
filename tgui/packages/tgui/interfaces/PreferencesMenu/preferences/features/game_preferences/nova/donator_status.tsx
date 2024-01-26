// THIS IS A NOVA SECTOR UI FILE
import { multiline } from 'common/string';

import { CheckboxInput, FeatureToggle } from '../../base';

export const display_donator_status: FeatureToggle = {
  name: 'Display Donator Status',
  category: 'CHAT',
  description: multiline`
    "When enabled, the Nova Sector logo will be displayed next to your name in
    OOC if you're a donator.
    `,
  component: CheckboxInput,
};
