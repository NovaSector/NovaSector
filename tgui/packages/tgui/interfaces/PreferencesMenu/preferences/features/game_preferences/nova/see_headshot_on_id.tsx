// THIS IS A NOVA SECTOR UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const see_headshot_on_id: FeatureToggle = {
  name: 'See player headshot on ID examine',
  category: 'CHAT',
  description:
    'If checked, you will see a player their character headshot on examine of their ID.',
  component: CheckboxInput,
};
