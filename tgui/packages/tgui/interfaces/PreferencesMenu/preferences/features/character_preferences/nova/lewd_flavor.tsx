// THIS IS A NOVA SECTOR UI FILE
import { type Feature, FeatureShortTextInput } from '../../base';

export const custom_taste: Feature<string> = {
  name: 'Flavor - Taste',
  description: 'Short ERP-gated text shown when someone licks you.',
  component: FeatureShortTextInput,
};

export const custom_smell: Feature<string> = {
  name: 'Flavor - Smell',
  description: 'Short ERP-gated text shown when someone smells you.',
  component: FeatureShortTextInput,
};

export const low_arousal_text: Feature<string> = {
  name: 'Flavor - Arousal (low)',
  description: 'Short ERP-gated text shown on examine when slightly aroused.',
  component: FeatureShortTextInput,
};

export const medium_arousal_text: Feature<string> = {
  name: 'Flavor - Arousal (medium)',
  description: 'Short ERP-gated text shown on examine when moderately aroused.',
  component: FeatureShortTextInput,
};

export const high_arousal_text: Feature<string> = {
  name: 'Flavor - Arousal (high)',
  description: 'Short ERP-gated text shown on examine when highly aroused.',
  component: FeatureShortTextInput,
};
