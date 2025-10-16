// THIS IS A NOVA SECTOR UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const allow_protean_lock: FeatureToggle = {
  name: 'Allow Protean Modsuit Lock',
  category: 'GAMEPLAY',
  description:
    'Allows proteans to lock their modsuit on you, preventing you from removing it until they unlock it or it is forcefully removed (acid, EMP, tools). This is an opt-in feature (disabled by default).',
  component: CheckboxInput,
};
