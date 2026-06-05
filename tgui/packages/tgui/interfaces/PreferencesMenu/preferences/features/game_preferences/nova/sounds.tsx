import { CheckboxInput, type FeatureToggle } from '../../base';

export const sound_eating: FeatureToggle = {
  name: 'Enable eating and drinking sounds',
  category: 'SOUND',
  description:
    'When enabled, hear eating and drinking sounds when appropriate.',
  component: CheckboxInput,
};

export const sound_loopalarm: FeatureToggle = {
  name: 'Enable looping alert level sounds',
  category: 'SOUND',
  description:
    'When enabled, hear looping alarms.',
  component: CheckboxInput,
};
