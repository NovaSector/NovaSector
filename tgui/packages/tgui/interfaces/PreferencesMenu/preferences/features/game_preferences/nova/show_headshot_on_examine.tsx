// THIS IS A NOVA SECTOR UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const show_headshot_on_examine: FeatureToggle = {
  name: 'Show headshot on examine',
  category: 'UI',
  description: `When enabled, examining someone whose face isn't covered shows
    their headshot in the chat, if they have one set. Hover over it to enlarge it.`,
  component: CheckboxInput,
};
